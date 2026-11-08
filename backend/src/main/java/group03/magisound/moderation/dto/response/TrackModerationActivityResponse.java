package group03.magisound.moderation.dto.response;

import java.time.Instant;

/**
 * DTO đại diện cho một bản ghi kiểm duyệt bài hát trong lịch sử hoạt động của nhân viên (UC-20.4).
 */
public record TrackModerationActivityResponse(
        Long submissionId,
        Long trackId,
        String trackTitle,
        String artistName,
        String action,
        String rejectionReason,
        String reviewerNote,
        Instant reviewedAt
) {}
