package group03.magisound.admin.service;

import group03.magisound.admin.dto.response.SystemStatisticsResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

/**
 * Repository tổng hợp chỉ số nền tảng (UC-22: View System Statistics).
 */
@Slf4j
@Repository
@RequiredArgsConstructor
public class SystemMetricsRepository {

    private final AdminStatisticsService adminStatisticsService;

    /**
     * Thực thi truy vấn tổng hợp số liệu nền tảng.
     */
    public SystemStatisticsResponse queryAggregatedPlatformMetrics(String period) {
        return adminStatisticsService.getSystemStatistics(period);
    }
}
