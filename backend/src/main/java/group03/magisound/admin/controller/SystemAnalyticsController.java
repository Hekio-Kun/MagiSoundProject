package group03.magisound.admin.controller;

import group03.magisound.admin.dto.response.SystemStatisticsResponse;
import group03.magisound.admin.service.SystemStatisticsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller tiếp nhận và xử lý các yêu cầu HTTP xem số liệu thống kê hệ thống (UC-22: View System Statistics).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/admin/statistics")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class SystemAnalyticsController {

    private final SystemStatisticsService systemStatisticsService;

    /**
     * Lấy dữ liệu thống kê tổng thể của toàn bộ hệ thống MagiSound theo khoảng thời gian chỉ định (UC-22).
     *
     * @param period Khoảng thời gian thống kê (mặc định là "7d")
     * @return DTO chứa dữ liệu tổng quan, top bài hát, biểu đồ tăng trưởng và cơ cấu người dùng
     */
    @GetMapping
    public ResponseEntity<SystemStatisticsResponse> getSystemStatistics(
            @RequestParam(required = false, defaultValue = "7d") String period) {
        log.info("Admin requesting system statistics with period={}", period);
        SystemStatisticsResponse response = systemStatisticsService.getSystemStatistics(period);
        return ResponseEntity.ok(response);
    }
}
