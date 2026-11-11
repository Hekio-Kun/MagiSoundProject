package group03.magisound.studio.dto.response;

import java.time.Instant;
import java.util.List;

/**
 * DTO phản hồi lý do từ chối kiểm duyệt (UC-15: View Rejection Reason).
 */
public record RejectionFeedbackResponse(
        Long trackId,
        String trackTitle,
        String status,
        String rejectionReason,
        String reviewerNote,
        Instant reviewedAt,
        List<RejectionHistoryItemResponse> feedbackHistory
) {
    public static RejectionFeedbackResponse fromDetails(RejectionDetailsResponse details) {
        if (details == null) return null;
        return new RejectionFeedbackResponse(
                details.trackId(),
                details.trackTitle(),
                details.status(),
                details.rejectionReason(),
                details.reviewerNote(),
                details.reviewedAt(),
                details.history()
        );
    }
}
