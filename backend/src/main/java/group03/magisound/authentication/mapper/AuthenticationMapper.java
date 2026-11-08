package group03.magisound.authentication.mapper;

import group03.magisound.authentication.dto.response.UserResponse;
import group03.magisound.authentication.entity.AppUser;
import org.springframework.stereotype.Component;

@Component
public class AuthenticationMapper {
    public UserResponse toUserResponse(AppUser user, String displayName, String avatarUrl) {
        return new UserResponse(user.getId(), user.getEmail(), displayName, avatarUrl, user.getRole().getCode());
    }
}
