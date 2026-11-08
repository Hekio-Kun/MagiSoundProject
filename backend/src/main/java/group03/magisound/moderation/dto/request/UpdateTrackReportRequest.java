package group03.magisound.moderation.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO yêu cầu cập nhật danh mục lý do vi phạm của báo cáo đang PENDING.
 */
public record UpdateTrackReportRequest(
        @NotBlank(message = "Report reason option is required")
        String category,

        @Size(max = 2000, message = "Description cannot exceed 2000 characters")
        String description
) {
    public UpdateTrackReportRequest(String category) {
        this(category, null);
    }
}
