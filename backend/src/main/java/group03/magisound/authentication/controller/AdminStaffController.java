package group03.magisound.authentication.controller;

import group03.magisound.authentication.dto.request.CreateStaffRequest;
import group03.magisound.authentication.dto.request.DeactivateStaffRequest;
import group03.magisound.authentication.dto.response.CreateStaffResponse;
import group03.magisound.authentication.dto.response.DeactivateStaffResponse;
import group03.magisound.authentication.dto.response.StaffDirectoryPageResponse;
import group03.magisound.authentication.dto.response.StaffModerationActivityResponse;
import group03.magisound.authentication.service.AdminStaffService;
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
 * Controller tiếp nhận và xử lý các yêu cầu HTTP quản trị tài khoản Staff dành cho Admin (UC-20: Manage Staff Accounts).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/admin/staffs")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminStaffController {

    private final AdminStaffService adminStaffService;

    /**
     * Lấy danh bạ tài khoản nhân viên kiểm duyệt (UC-20.1: View Staff Directory).
     */
    @GetMapping
    public ResponseEntity<StaffDirectoryPageResponse> getStaffDirectory(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String role,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        log.info("Admin requesting staff directory: search='{}', status='{}', role='{}', page={}, size={}",
                search, status, role, pageable.getPageNumber(), pageable.getPageSize());

        StaffDirectoryPageResponse response = adminStaffService.getStaffDirectory(search, status, role, pageable);
        return ResponseEntity.ok(response);
    }

    /**
     * Khởi tạo tài khoản nhân viên kiểm duyệt mới (UC-20.2: Create Staff Account).
     */
    @PostMapping
    public ResponseEntity<CreateStaffResponse> createStaff(
            @Valid @RequestBody CreateStaffRequest request
    ) {
        log.info("Admin requesting to create new staff account for email: {}", request.email());

        CreateStaffResponse response = adminStaffService.createStaff(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Vô hiệu hóa tài khoản nhân viên kiểm duyệt (UC-20.3: Deactivate Staff Account).
     */
    @PatchMapping("/{id}/deactivate")
    public ResponseEntity<DeactivateStaffResponse> deactivateStaff(
            @PathVariable Long id,
            @Valid @RequestBody DeactivateStaffRequest request
    ) {
        log.info("Admin requesting to deactivate staff account with ID: {}", id);

        DeactivateStaffResponse response = adminStaffService.deactivateStaff(id, request);
        return ResponseEntity.ok(response);
    }

    /**
     * Lấy toàn bộ lịch sử hoạt động kiểm duyệt của nhân viên (UC-20.4: View Staff Moderation Activity).
     */
    @GetMapping("/{id}/activity")
    public ResponseEntity<StaffModerationActivityResponse> getStaffModerationActivity(
            @PathVariable Long id
    ) {
        log.info("Admin requesting moderation activity for staff ID: {}", id);

        StaffModerationActivityResponse response = adminStaffService.getStaffModerationActivity(id);
        return ResponseEntity.ok(response);
    }
}
