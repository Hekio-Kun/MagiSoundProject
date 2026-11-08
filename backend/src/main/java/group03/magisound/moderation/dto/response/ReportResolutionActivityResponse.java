package group03.magisound.moderation.dto.response;

import java.time.Instant;

/**
 * DTO đại diện cho một bản ghi xử lý báo cáo vi phạm trong lịch sử hoạt động của nhân viên (UC-20.4).
 */
public record ReportResolutionActivityResponse(
        Long reportId,
        String category,
        String targetType,
        Long targetId,
        String targetTitle,
        String decision,
        String resolutionNote,
        Instant resolvedAt
) {}
