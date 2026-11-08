package group03.magisound.authentication.dto.response;

public record AuthResponse(String accessToken, String tokenType, long expiresInSeconds, UserResponse user) {}
