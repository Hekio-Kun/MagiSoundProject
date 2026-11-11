package group03.magisound.moderation.controller;

import group03.magisound.moderation.dto.request.*;
import group03.magisound.moderation.dto.response.*;
import group03.magisound.moderation.service.ContentReportService;
import group03.magisound.moderation.service.StaffContentReportService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;

/**
 * Controller tiếp nhận và xử lý các báo cáo vi phạm nội dung theo đặc tả Sequence Diagram:
 * - UC-16.1 & UC-16.2: Người dùng gửi và xem lại báo cáo vi phạm
 * - UC-18.1 & UC-18.2: Nhân viên kiểm duyệt xem hàng đợi và xử lý báo cáo vi phạm
 */
@Slf4j
@RestController
@RequiredArgsConstructor
public class ContentReportController {

    private final ContentReportService contentReportService;
    private final StaffContentReportService staffContentReportService;

    // =========================================================================
    // UC-16: User Report Actions (/api/v1/reports)
    // =========================================================================

    /**
     * Báo cáo vi phạm nội dung đối với bài hát đã phát hành (UC-16.1).
     */
    @PostMapping("/api/v1/reports")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<TrackReportResponse> reportTrack(
            @Valid @RequestBody CreateTrackReportRequest request,
            Authentication authentication
    ) {
        TrackReportResponse response = contentReportService.submitTrackReport(
                authentication.getName(),
                request
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Cập nhật danh mục lý do vi phạm của báo cáo vi phạm nội dung đang chờ duyệt.
     */
    @PutMapping("/api/v1/reports/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<TrackReportResponse> updateTrackReport(
            @PathVariable("id") Long id,
            @Valid @RequestBody UpdateTrackReportRequest request,
            Authentication authentication
    ) {
        TrackReportResponse response = contentReportService.updateTrackReport(
                id,
                authentication.getName(),
                request
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Rút lại (hủy) báo cáo vi phạm nội dung đang ở trạng thái PENDING.
     */
    @DeleteMapping("/api/v1/reports/{id}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Map<String, Object>> withdrawTrackReport(
            @PathVariable("id") Long id,
            Authentication authentication
    ) {
        contentReportService.withdrawTrackReport(
                id,
                authentication.getName()
        );
        return ResponseEntity.ok(Map.of(
                "reportId", id,
                "message", "Report has been withdrawn successfully"
        ));
    }

    /**
     * Lấy toàn bộ lịch sử các báo cáo vi phạm do người nghe gửi (UC-16.2).
     * Hỗ trợ cả /api/v1/reports/me (chuẩn Sequence) và /api/v1/reports/my-reports (tương thích frontend).
     */
    @GetMapping({"/api/v1/reports/me", "/api/v1/reports/my-reports"})
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<MyReportHistoryResponse>> getMyReports(Authentication authentication) {
        List<MyReportHistoryResponse> response = contentReportService.getMyReports(authentication.getName());
        return ResponseEntity.ok(response);
    }

    /**
     * Kiểm tra xem người dùng hiện tại đã có báo cáo PENDING cho bài hát hay chưa.
     */
    @GetMapping("/api/v1/reports/check")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Map<String, Object>> checkPendingReport(
            @RequestParam("trackId") Long trackId,
            Authentication authentication
    ) {
        boolean hasPending = contentReportService.checkPendingReport(
                authentication.getName(),
                trackId
        );
        return ResponseEntity.ok(Map.of(
                "trackId", trackId,
                "hasPendingReport", hasPending
        ));
    }

    /**
     * Báo cáo lỗi lời bài hát.
     */
    @PostMapping("/api/v1/reports/lyrics")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<ContentReportResponse> reportLyric(
            @Valid @RequestBody CreateContentReportRequest request,
            Authentication authentication
    ) {
        ContentReportResponse response = contentReportService.submitLyricReport(
                authentication.getName(),
                request
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    // =========================================================================
    // UC-18: Staff Content Report Actions (/api/v1/moderation/reports & /api/v1/staff/reports)
    // =========================================================================

    /**
     * Xem hàng đợi báo cáo vi phạm nội dung (UC-18.1: View User Reports).
     */
    @GetMapping({"/api/v1/moderation/reports", "/api/v1/staff/reports"})
    @PreAuthorize("hasRole('STAFF') or hasRole('ADMIN')")
    public ResponseEntity<List<StaffContentReportResponse>> getReportsQueue() {
        return ResponseEntity.ok(staffContentReportService.getReportsQueue());
    }

    /**
     * Xem chi tiết một báo cáo vi phạm nội dung.
     */
    @GetMapping({"/api/v1/moderation/reports/{id}", "/api/v1/staff/reports/{id}"})
    @PreAuthorize("hasRole('STAFF') or hasRole('ADMIN')")
    public ResponseEntity<StaffContentReportResponse> getReportById(@PathVariable Long id) {
        return ResponseEntity.ok(staffContentReportService.getReportById(id));
    }

    /**
     * Xử lý giải quyết báo cáo vi phạm nội dung (UC-18.2: Resolve Content Report).
     */
    @PostMapping({"/api/v1/moderation/reports/{id}/resolve", "/api/v1/staff/reports/{id}/resolve"})
    @PreAuthorize("hasRole('STAFF') or hasRole('ADMIN')")
    public ResponseEntity<StaffContentReportResponse> resolveReport(
            @PathVariable Long id,
            @Valid @RequestBody ResolveContentReportRequest request,
            Principal principal
    ) {
        return ResponseEntity.ok(staffContentReportService.resolveReport(id, request, principal.getName()));
    }

    /**
     * Gỡ bỏ bài hát đã phát hành vi phạm theo yêu cầu xử lý báo cáo.
     */
    @PostMapping("/api/v1/staff/tracks/{trackId}/takedown")
    @PreAuthorize("hasRole('STAFF') or hasRole('ADMIN')")
    public ResponseEntity<Void> takeDownTrack(
            @PathVariable Long trackId,
            @Valid @RequestBody TakeDownTrackRequest request,
            Principal principal
    ) {
        staffContentReportService.takeDownPublishedTrack(trackId, request, principal.getName());
        return ResponseEntity.noContent().build();
    }
}
