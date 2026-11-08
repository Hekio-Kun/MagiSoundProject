package group03.magisound.authentication.dto.response;

import java.time.LocalDateTime;

/**
 * DTO tóm tắt thông tin tài khoản nhân viên kiểm duyệt cho giao diện quản trị Admin (UC-20.1: View Staff Directory).
 */
public record StaffSummaryResponse(
        Long id,
        String email,
        String fullName,
        String roleCode,
        String roleName,
        String status,
        String avatarUrl,
        LocalDateTime lastLoginAt,
        LocalDateTime createdAt,
        long totalTracksModerated,
        long totalReportsResolved
) {}
