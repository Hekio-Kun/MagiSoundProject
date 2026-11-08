package group03.magisound.admin.dto.response;

import java.time.LocalDateTime;

/**
 * DTO đại diện cho tài khoản vừa đăng ký/xác thực trong danh sách gần đây (UC-22).
 */
public record RecentAccountStatisticResponse(
        Long id,
        String email,
        String displayName,
        String role,
        String status,
        LocalDateTime joinedAt,
        String initials,
        String avatarUrl
) {}
