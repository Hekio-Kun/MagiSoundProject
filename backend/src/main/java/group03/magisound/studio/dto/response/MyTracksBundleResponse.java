package group03.magisound.studio.dto.response;

import java.util.List;

/**
 * DTO gói dữ liệu danh sách bài hát của tác giả theo UC-14.2 (View My Tracks List).
 */
public record MyTracksBundleResponse(
        List<StudioTrackResponse> items,
        long totalItems,
        int totalPages,
        int currentPage
) {
}
