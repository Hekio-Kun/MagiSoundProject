package group03.magisound.authentication.controller;

import group03.magisound.authentication.dto.request.CreateStaffRequest;
import group03.magisound.authentication.dto.request.DeactivateStaffRequest;
import group03.magisound.authentication.dto.response.CreateStaffResponse;
import group03.magisound.authentication.dto.response.DeactivateStaffResponse;
import group03.magisound.authentication.dto.response.StaffActivitySummaryResponse;
import group03.magisound.authentication.dto.response.StaffDirectoryResponse;
import group03.magisound.authentication.service.StaffAuditService;
import group03.magisound.authentication.service.StaffManagementService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

/**
 * Controller quản lý tài khoản nhân viên theo đặc tả Sequence Diagram UC-20 (20.1 -> 20.4).
 */
@Slf4j
@RestController
@RequestMapping({"/api/v1/admin/staff", "/api/v1/admin/staffs"})
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class StaffManagementController {

    private final StaffManagementService staffManagementService;
    private final StaffAuditService staffAuditService;

    /**
     * Lấy danh bạ tài khoản nhân viên kiểm duyệt (UC-20.1: View Staff Directory).
     */
    @GetMapping
    public ResponseEntity<StaffDirectoryResponse> getStaffDirectory(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String role,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        log.info("Fetching staff directory: search='{}', status='{}', role='{}'", search, status, role);
        StaffDirectoryResponse response = staffManagementService.getStaffDirectory(search, status, role, pageable);
        return ResponseEntity.ok(response);
    }

    /**
     * Khởi tạo tài khoản nhân viên kiểm duyệt mới (UC-20.2: Create Staff Account).
     */
    @PostMapping
    public ResponseEntity<CreateStaffResponse> createStaff(
            @Valid @RequestBody CreateStaffRequest request
    ) {
        log.info("Creating new staff account for email: {}", request.email());
        CreateStaffResponse response = staffManagementService.createStaff(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Vô hiệu hóa tài khoản nhân viên kiểm duyệt (UC-20.3: Deactivate Staff Account).
     * Hỗ trợ cả PUT và PATCH theo chuẩn RESTful và Sequence Diagram.
     */
    @RequestMapping(value = "/{id}/deactivate", method = {RequestMethod.PUT, RequestMethod.PATCH})
    public ResponseEntity<DeactivateStaffResponse> deactivateStaff(
            @PathVariable Long id,
            @Valid @RequestBody DeactivateStaffRequest request
    ) {
        log.info("Deactivating staff account with ID: {}", id);
        DeactivateStaffResponse response = staffManagementService.deactivateStaff(id, request);
        return ResponseEntity.ok(response);
    }

    /**
     * Xem toàn bộ lịch sử hoạt động kiểm duyệt của nhân viên (UC-20.4: View Staff Activity).
     */
    @GetMapping("/{id}/activity")
    public ResponseEntity<StaffActivitySummaryResponse> getStaffActivity(
            @PathVariable Long id
    ) {
        log.info("Fetching moderation activity for staff ID: {}", id);
        StaffActivitySummaryResponse response = staffAuditService.getStaffActivitySummary(id);
        return ResponseEntity.ok(response);
    }
}
