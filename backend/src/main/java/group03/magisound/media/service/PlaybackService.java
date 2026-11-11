package group03.magisound.media.service;

import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.catalog.service.TrackCatalogService;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.media.dto.response.PlaybackSyncResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service điều khiển phát nhạc và đồng bộ hàng đợi theo đặc tả Sequence Diagram UC-10 (Control Playback).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PlaybackService {

    private final TrackRepository trackRepository;
    private final TrackCatalogService trackCatalogService;

    @Transactional(readOnly = true)
    public PlaybackSyncResponse loadNextTrackInQueue(Long nextTrackId) {
        if (nextTrackId == null) {
            throw new ResourceNotFoundException("TRACK_UNAVAILABLE", "Next track ID is required.");
        }

        Track track = trackRepository.findByIdAndStatus(nextTrackId, TrackPublicationStatus.PUBLISHED)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_UNAVAILABLE", "Next track is unavailable or deleted."));

        TrackResponse response = trackCatalogService.mapToTrackResponse(track);
        return new PlaybackSyncResponse(
                track.getId(),
                track.getTitle(),
                track.getAudioUrl(),
                track.getDurationMs(),
                track.getPublicationStatus().name(),
                response
        );
    }
}
