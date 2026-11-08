package group03.magisound.authentication.dto.response;

import org.springframework.data.domain.Page;

import java.util.List;

/**
 * DTO phản hồi phân trang danh bạ nhân viên kiểm duyệt cho Admin (UC-20.1: View Staff Directory).
 */
public record StaffDirectoryPageResponse(
        List<StaffSummaryResponse> content,
        long totalElements,
        int totalPages,
        int size,
        int number,
        boolean first,
        boolean last
) {
    public static StaffDirectoryPageResponse of(Page<StaffSummaryResponse> page) {
        return new StaffDirectoryPageResponse(
                List.copyOf(page.getContent()),
                page.getTotalElements(),
                page.getTotalPages(),
                page.getSize(),
                page.getNumber(),
                page.isFirst(),
                page.isLast()
        );
    }
}
