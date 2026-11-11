package group03.magisound.catalog.dto.response;

import java.util.List;

/**
 * DTO kết quả tìm kiếm danh mục công khai theo UC-07 (Search Public Catalog).
 */
public record SearchCatalogResponse(
        List<TrackResponse> tracks,
        int totalPages,
        long totalElements
) {
    public SearchCatalogResponse(List<TrackResponse> tracks, int totalPages) {
        this(tracks, totalPages, tracks != null ? tracks.size() : 0);
    }
}
