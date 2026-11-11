package group03.magisound.catalog.dto.response;

import java.util.List;

/**
 * DTO gói danh sách thể loại theo đặc tả UC-21 (Genre Management: View, Search, Filter Genres).
 */
public record GenreBundleResponse(
        List<AdminGenreResponse> items,
        long totalItems,
        int totalPages,
        int currentPage
) {
    public GenreBundleResponse(List<AdminGenreResponse> items) {
        this(items, items != null ? items.size() : 0, 1, 0);
    }
}
