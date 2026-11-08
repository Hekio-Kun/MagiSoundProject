package group03.magisound.admin.dto.response;

/**
 * DTO chứa các chỉ số đo lường tổng thể của hệ thống dành cho Admin Dashboard (UC-22).
 */
public record MetricOverviewResponse(
        long totalUsers,
        long activeUsers,
        long newUsersInPeriod,
        double userGrowthPercentage,
        long publishedTracks,
        long newTracksInPeriod,
        long totalPlays,
        long pendingReviews,
        long pendingReports,
        long activeGenres,
        long totalCreators
) {}
