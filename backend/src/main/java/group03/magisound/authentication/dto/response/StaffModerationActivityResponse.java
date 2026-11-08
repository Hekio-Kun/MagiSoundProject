package group03.magisound.authentication.dto.response;

import group03.magisound.moderation.dto.response.ReportResolutionActivityResponse;
import group03.magisound.moderation.dto.response.TrackModerationActivityResponse;

import java.util.List;

/**
 * DTO tổng hợp lịch sử hoạt động kiểm duyệt của một nhân viên (UC-20.4: View Staff Moderation Activity).
 */
public record StaffModerationActivityResponse(
        Long staffId,
        String fullName,
        String email,
        String roleCode,
        String roleName,
        String status,
        long totalTracksModerated,
        long totalReportsResolved,
        List<TrackModerationActivityResponse> trackReviews,
        List<ReportResolutionActivityResponse> reportResolutions
) {}
