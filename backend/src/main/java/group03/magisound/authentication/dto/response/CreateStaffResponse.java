package group03.magisound.authentication.dto.response;

import java.time.LocalDateTime;

/**
 * DTO phản hồi sau khi khởi tạo tài khoản nhân viên kiểm duyệt thành công (UC-20.2).
 */
public record CreateStaffResponse(
        Long id,
        String email,
        String fullName,
        String roleCode,
        String roleName,
        String status,
        String temporaryPassword,
        boolean emailDispatched,
        LocalDateTime createdAt
) {}
