package group03.magisound.authentication.dto.response;

public record LoginResult(AuthResponse response, String refreshToken, long refreshTokenMaxAgeSeconds) {}
