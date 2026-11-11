package group03.magisound.catalog.dto.response;

import java.util.List;

/**
 * DTO gói dữ liệu danh sách bài hát gợi ý theo UC-06 (View Recommended Songs).
 */
public record RecommendedTracksBundleResponse(
        List<TrackResponse> trending,
        List<TrackResponse> newReleases,
        List<GenreResponse> popularGenres
) {
}
