package group03.magisound.authentication.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record LoginRequest(
        @NotBlank @Email String email,
        @NotBlank String password,
        Boolean rememberMe
) {
    public LoginRequest {
        if (rememberMe == null) {
            rememberMe = Boolean.FALSE;
        }
    }
}
