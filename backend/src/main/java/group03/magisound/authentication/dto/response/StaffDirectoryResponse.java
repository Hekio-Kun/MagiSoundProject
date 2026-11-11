package group03.magisound.authentication.dto.response;

import java.util.List;

/**
 * DTO danh bạ tài khoản nhân viên kiểm duyệt theo UC-20.1 (View Staff Directory).
 */
public record StaffDirectoryResponse(
        List<StaffSummaryResponse> content,
        int page,
        int size,
        long totalElements,
        int totalPages,
        boolean last
) {
    public static StaffDirectoryResponse fromPageResponse(StaffDirectoryPageResponse page) {
        if (page == null) return null;
        return new StaffDirectoryResponse(
                page.content(),
                page.number(),
                page.size(),
                page.totalElements(),
                page.totalPages(),
                page.last()
        );
    }
}
