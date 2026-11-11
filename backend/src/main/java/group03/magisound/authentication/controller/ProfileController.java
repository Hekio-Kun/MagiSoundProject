package group03.magisound.authentication.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import group03.magisound.authentication.dto.request.ChangePasswordRequest;
import group03.magisound.authentication.dto.request.UpdateProfileRequest;
import group03.magisound.authentication.dto.response.ProfileResponse;
import group03.magisound.authentication.service.ProfileService;
import org.springframework.security.core.Authentication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final ProfileService profileService;

    /**
     * Trả hồ sơ của tài khoản đang đăng nhập.
     */
    @GetMapping
    public ProfileResponse getCurrentProfile(Authentication authentication) {
        return profileService.getCurrentProfile(authentication.getName());
    }

    /**
     * Trả hồ sơ công khai của người dùng / creator theo userId.
     */
    @GetMapping("/{userId}")
    public ProfileResponse getPublicProfile(@PathVariable Long userId) {
        return profileService.getPublicProfile(userId);
    }

    /**
     * Cập nhật hồ sơ của tài khoản đang đăng nhập.
     */
    @PatchMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ProfileResponse updateCurrentProfile(Authentication authentication,
                                                @Valid @RequestBody UpdateProfileRequest request) {
        return profileService.updateCurrentProfile(authentication.getName(), request);
    }

    /**
     * Cập nhật hồ sơ và tải avatar mới của tài khoản đang đăng nhập.
     */
    @PatchMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ProfileResponse updateCurrentProfileWithAvatar(Authentication authentication,
                                                          @Valid @RequestPart("profile") UpdateProfileRequest request,
                                                          @RequestPart("avatar") MultipartFile avatar) {
        return profileService.updateCurrentProfile(authentication.getName(), request, avatar);
    }

    /**
     * Đổi mật khẩu tài khoản đang đăng nhập (TC-15).
     */
    @PostMapping("/change-password")
    public Map<String, String> changePassword(Authentication authentication,
                                              @Valid @RequestBody ChangePasswordRequest request) {
        profileService.changePassword(authentication.getName(), request);
        return Map.of("message", "Đổi mật khẩu thành công!");
    }
}
