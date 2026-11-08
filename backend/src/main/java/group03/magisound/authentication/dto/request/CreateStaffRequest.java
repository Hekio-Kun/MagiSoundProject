package group03.magisound.authentication.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO yêu cầu khởi tạo tài khoản nhân viên kiểm duyệt mới từ Admin (UC-20.2: Create Staff Account).
 */
public record CreateStaffRequest(
        @NotBlank(message = "Full name is required")
        @Size(min = 2, max = 120, message = "Full name must be between 2 and 120 characters")
        String fullName,

        @NotBlank(message = "Email is required")
        @Email(message = "Email must be a valid email address")
        @Size(max = 320, message = "Email must not exceed 320 characters")
        String email,

        String password,

        Boolean autoGeneratePassword
) {
    public CreateStaffRequest(String fullName, String email) {
        this(fullName, email, null, true);
    }
}
