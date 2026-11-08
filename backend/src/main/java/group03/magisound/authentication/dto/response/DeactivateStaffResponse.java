package group03.magisound.authentication.dto.response;

import java.time.LocalDateTime;

/**
 * DTO phản hồi kết quả sau khi vô hiệu hóa tài khoản nhân viên kiểm duyệt (UC-20.3).
 */
public record DeactivateStaffResponse(
        Long id,
        String email,
        String fullName,
        String roleCode,
        String status,
        String reason,
        LocalDateTime deactivatedAt
) {}
