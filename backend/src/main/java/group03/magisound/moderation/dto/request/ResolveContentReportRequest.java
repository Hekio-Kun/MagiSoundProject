package group03.magisound.moderation.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO yêu cầu giải quyết báo cáo nội dung từ nhân viên kiểm duyệt (UC-18.2).
 */
public record ResolveContentReportRequest(
        @NotBlank(message = "Resolution decision is required")
        String decision,

        @NotBlank(message = "Staff Note is required")
        @Size(max = 2000, message = "Staff Note cannot exceed 2000 characters")
        String staffNote
) {}
