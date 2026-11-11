package group03.magisound.media.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.library.service.ListeningHistoryPublicService;
import group03.magisound.media.dto.response.AudioStreamChunkResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.ResourceRegion;
import org.springframework.http.HttpRange;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;

/**
 * Service phát luồng âm thanh theo đặc tả Sequence Diagram UC-09 (Play Music).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class MediaStreamingService {

    private final TrackRepository trackRepository;
    private final ServerStorageService serverStorageService;
    private final ListeningHistoryPublicService listeningHistoryPublicService;
    private final AppUserRepository appUserRepository;

    @Transactional(readOnly = true)
    public ResourceRegion streamAudioRegion(Long trackId, String rangeHeader) throws IOException {
        Track track = trackRepository.findByIdAndStatus(trackId, TrackPublicationStatus.PUBLISHED)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_UNAVAILABLE", "Track not approved or file missing."));

        String filePath = track.getAudioUrl();
        if (filePath == null || filePath.isBlank()) {
            throw new ResourceNotFoundException("AUDIO_FILE_MISSING", "Audio file path is not set.");
        }

        Resource audioResource = serverStorageService.loadAudioResource(filePath);
        long contentLength = audioResource.contentLength();

        if (rangeHeader == null || rangeHeader.isBlank()) {
            return new ResourceRegion(audioResource, 0, Math.min(1024 * 1024L, contentLength));
        }

        HttpRange range = HttpRange.parseRanges(rangeHeader).get(0);
        long start = range.getRangeStart(contentLength);
        long end = range.getRangeEnd(contentLength);
        long rangeLength = Math.min(1024 * 1024L, end - start + 1);

        return new ResourceRegion(audioResource, start, rangeLength);
    }

    @Transactional(readOnly = true)
    public AudioStreamChunkResponse streamAudioChunk(Long trackId, String rangeHeader) throws IOException {
        Track track = trackRepository.findByIdAndStatus(trackId, TrackPublicationStatus.PUBLISHED)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_UNAVAILABLE", "Track not approved or file missing."));

        String filePath = track.getAudioUrl();
        Resource audioResource = serverStorageService.loadAudioResource(filePath);
        long contentLength = audioResource.contentLength();

        long start = 0;
        long end = Math.min(1048575L, contentLength - 1);
        if (rangeHeader != null && !rangeHeader.isBlank()) {
            HttpRange range = HttpRange.parseRanges(rangeHeader).get(0);
            start = range.getRangeStart(contentLength);
            end = Math.min(range.getRangeEnd(contentLength), start + 1048575L);
        }

        byte[] chunk = serverStorageService.readByteRange(filePath, start, end);
        String contentRange = "bytes " + start + "-" + (start + chunk.length - 1) + "/" + contentLength;

        return new AudioStreamChunkResponse(chunk, contentRange, contentLength);
    }

    /**
     * Ghi nhận lượt nghe hợp lệ (sau khi nghe tối thiểu 30 giây theo BR-08 / Phase 3).
     */
    @Transactional
    public void recordValidPlay(Long trackId, String userEmail) {
        Track track = trackRepository.findByIdAndStatus(trackId, TrackPublicationStatus.PUBLISHED)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_UNAVAILABLE", "Track unavailable"));

        trackRepository.incrementPlayCount(trackId);

        if (userEmail != null && !userEmail.isBlank()) {
            appUserRepository.findByEmailIgnoreCase(userEmail.trim()).ifPresent(user -> {
                listeningHistoryPublicService.recordListeningHistory(
                        user.getId(), trackId, 30000, true
                );
            });
        }
        log.info("Valid 30s playback recorded for trackId={}, user={}", trackId, userEmail);
    }
}
