package group03.magisound.moderation.dto.response;

import java.util.List;

/**
 * DTO tổng hợp lịch sử hoạt động kiểm duyệt từ module moderation để cung cấp cho module administration (UC-20.4).
 */
public record ModerationActivityBundleResponse(
        long totalTracksModerated,
        long totalReportsResolved,
        List<TrackModerationActivityResponse> trackReviews,
        List<ReportResolutionActivityResponse> reportResolutions
) {}
