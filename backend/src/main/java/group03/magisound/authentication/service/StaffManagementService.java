package group03.magisound.authentication.service;

import group03.magisound.authentication.dto.request.CreateStaffRequest;
import group03.magisound.authentication.dto.request.DeactivateStaffRequest;
import group03.magisound.authentication.dto.response.CreateStaffResponse;
import group03.magisound.authentication.dto.response.DeactivateStaffResponse;
import group03.magisound.authentication.dto.response.StaffDirectoryPageResponse;
import group03.magisound.authentication.dto.response.StaffDirectoryResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service quản lý tài khoản nhân viên kiểm duyệt theo đặc tả Sequence Diagram UC-20 (20.1 -> 20.3).
 */
@Service
@RequiredArgsConstructor
public class StaffManagementService {

    private final AdminStaffService adminStaffService;

    @Transactional(readOnly = true)
    public StaffDirectoryResponse getStaffDirectory(Pageable pageable) {
        StaffDirectoryPageResponse page = adminStaffService.getStaffDirectory(null, null, null, pageable);
        return StaffDirectoryResponse.fromPageResponse(page);
    }

    @Transactional(readOnly = true)
    public StaffDirectoryResponse getStaffDirectory(String search, String status, String role, Pageable pageable) {
        StaffDirectoryPageResponse page = adminStaffService.getStaffDirectory(search, status, role, pageable);
        return StaffDirectoryResponse.fromPageResponse(page);
    }

    @Transactional
    public CreateStaffResponse createStaff(CreateStaffRequest request) {
        return adminStaffService.createStaff(request);
    }

    @Transactional
    public DeactivateStaffResponse deactivateStaff(Long id, DeactivateStaffRequest request) {
        return adminStaffService.deactivateStaff(id, request);
    }
}
