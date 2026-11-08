package group03.magisound.moderation.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * DTO yêu cầu gửi báo cáo vi phạm nội dung bài hát đã phát hành (UC-16.1).
 */
public record CreateTrackReportRequest(
        @NotNull(message = "Track ID is required")
        Long trackId,

        @NotBlank(message = "Report reason option is required")
        String category,

        @Size(max = 2000, message = "Description cannot exceed 2000 characters")
        String description
) {
    public CreateTrackReportRequest(Long trackId, String category) {
        this(trackId, category, null);
    }
}
