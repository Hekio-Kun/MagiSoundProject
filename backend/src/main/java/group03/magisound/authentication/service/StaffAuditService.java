package group03.magisound.authentication.service;

import group03.magisound.authentication.dto.response.StaffActivitySummaryResponse;
import group03.magisound.authentication.dto.response.StaffModerationActivityResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service tra cứu và kiểm toán hoạt động của nhân viên kiểm duyệt (UC-20.4 View Staff Activity).
 */
@Service
@RequiredArgsConstructor
public class StaffAuditService {

    private final AdminStaffService adminStaffService;

    @Transactional(readOnly = true)
    public StaffActivitySummaryResponse getStaffActivitySummary(Long staffId) {
        StaffModerationActivityResponse activity = adminStaffService.getStaffModerationActivity(staffId);
        return StaffActivitySummaryResponse.fromModerationActivity(activity);
    }
}
