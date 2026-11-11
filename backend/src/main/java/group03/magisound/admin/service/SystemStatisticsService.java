package group03.magisound.admin.service;

import group03.magisound.admin.dto.response.SystemStatisticsResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service xử lý thống kê hệ thống theo đặc tả Sequence Diagram UC-22 (View System Statistics).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class SystemStatisticsService {

    private final SystemMetricsRepository systemMetricsRepository;

    @Transactional(readOnly = true)
    public SystemStatisticsResponse getSystemStatistics() {
        return getSystemStatistics("7d");
    }

    @Transactional(readOnly = true)
    public SystemStatisticsResponse getSystemStatistics(String period) {
        log.info("Fetching system statistics for period: {}", period);
        try {
            return systemMetricsRepository.queryAggregatedPlatformMetrics(period);
        } catch (Exception e) {
            log.error("Error executing system metrics query: {}", e.getMessage(), e);
            throw e;
        }
    }
}
