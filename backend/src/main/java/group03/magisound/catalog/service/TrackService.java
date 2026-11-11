package group03.magisound.catalog.service;

import group03.magisound.catalog.dto.response.TrackDetailResponse;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service lấy chi tiết bài hát công khai theo đặc tả Sequence Diagram UC-08 (View Track Details).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class TrackService {

    private final TrackRepository trackRepository;

    @Transactional(readOnly = true)
    public TrackDetailResponse getTrackDetail(Long trackId) {
        if (trackId == null) {
            throw new ResourceNotFoundException("TRACK_NOT_FOUND", "Track ID cannot be null.");
        }

        Track track = trackRepository.findByIdAndStatus(trackId, TrackPublicationStatus.PUBLISHED)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track is no longer available."));

        return TrackDetailResponse.fromTrack(track);
    }
}
