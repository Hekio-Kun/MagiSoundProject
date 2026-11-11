package group03.magisound.authentication.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record ChangePasswordRequest(
        @NotBlank(message = "Current password is required")
        String currentPassword,

        @NotBlank(message = "New password is required")
        @Size(min = 8, max = 72, message = "Password must be between 8 and 72 characters")
        @Pattern(regexp = "^(?=.*[A-Z])(?=.*\\d).+$", message = "Password must contain an uppercase letter and a number")
        String newPassword,

        @NotBlank(message = "Confirm password is required")
        String confirmPassword
) {}
