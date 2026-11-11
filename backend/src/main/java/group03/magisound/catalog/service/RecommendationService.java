package group03.magisound.catalog.service;

import group03.magisound.catalog.dto.response.GenreResponse;
import group03.magisound.catalog.dto.response.RecommendedTracksBundleResponse;
import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.GenreRepository;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service xử lý gợi ý bài hát theo đặc tả Sequence Diagram UC-06 (View Recommended Songs).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final TrackRepository trackRepository;
    private final GenreRepository genreRepository;
    private final TrackCatalogService trackCatalogService;
    private final GenreService genreService;

    @Transactional(readOnly = true)
    public RecommendedTracksBundleResponse getRecommendations(String userId, int limit) {
        int targetLimit = limit > 0 ? limit : 20;

        // 1. Trending tracks (top by play count)
        List<Track> trendingTracks = trackRepository.findTopTracksByPlayCount(
                TrackPublicationStatus.PUBLISHED, PageRequest.of(0, targetLimit)
        );

        if (trendingTracks.isEmpty()) {
            throw new ResourceNotFoundException("CATALOG_EMPTY", "No approved tracks found in database.");
        }

        List<TrackResponse> trendingResponses = trendingTracks.stream()
                .map(trackCatalogService::mapToTrackResponse)
                .toList();

        // 2. New releases (latest published)
        List<TrackResponse> newReleases = trackRepository.findByPublicationStatus(
                TrackPublicationStatus.PUBLISHED, PageRequest.of(0, targetLimit)
        ).getContent().stream()
                .map(trackCatalogService::mapToTrackResponse)
                .toList();

        // 3. Popular genres
        List<GenreResponse> popularGenres = genreService.getActiveGenres();

        return new RecommendedTracksBundleResponse(trendingResponses, newReleases, popularGenres);
    }
}
