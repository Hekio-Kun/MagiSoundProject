package group03.magisound.authentication.dto.response;

import group03.magisound.moderation.dto.response.ReportResolutionActivityResponse;
import group03.magisound.moderation.dto.response.TrackModerationActivityResponse;

import java.util.List;

/**
 * DTO tóm tắt lịch sử hoạt động kiểm duyệt của nhân viên theo UC-20.4 (View Staff Activity).
 */
public record StaffActivitySummaryResponse(
        Long staffId,
        String fullName,
        String email,
        String roleCode,
        String roleName,
        String status,
        long totalTracksModerated,
        long totalReportsResolved,
        List<TrackModerationActivityResponse> trackReviews,
        List<ReportResolutionActivityResponse> reportResolutions
) {
    public static StaffActivitySummaryResponse fromModerationActivity(StaffModerationActivityResponse activity) {
        if (activity == null) return null;
        return new StaffActivitySummaryResponse(
                activity.staffId(),
                activity.fullName(),
                activity.email(),
                activity.roleCode(),
                activity.roleName(),
                activity.status(),
                activity.totalTracksModerated(),
                activity.totalReportsResolved(),
                activity.trackReviews(),
                activity.reportResolutions()
        );
    }
}
