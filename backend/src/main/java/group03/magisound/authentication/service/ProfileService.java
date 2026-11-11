package group03.magisound.authentication.service;

import lombok.RequiredArgsConstructor;
import group03.magisound.authentication.dto.request.UpdateProfileRequest;
import group03.magisound.authentication.dto.response.ProfileResponse;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.exception.ProfileNotFoundException;
import group03.magisound.authentication.exception.UsernameAlreadyExistsException;
import group03.magisound.authentication.mapper.ProfileMapper;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.media.dto.response.StoredMediaResponse;
import group03.magisound.media.service.CloudMediaService;
import group03.magisound.authentication.dto.request.ChangePasswordRequest;
import group03.magisound.authentication.entity.AppUser;
import group03.magisound.exception.BadRequestOperationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class ProfileService {
    private final UserProfileRepository profileRepository;
    private final ProfileMapper profileMapper;
    private final CloudMediaService cloudMediaService;
    private final PasswordEncoder passwordEncoder;

    /**
     * Lấy hồ sơ đầy đủ của người dùng hiện tại.
     */
    @Transactional(readOnly = true)
    public ProfileResponse getCurrentProfile(String email) {
        return profileMapper.toResponse(findByEmail(email));
    }

    /**
     * Lấy hồ sơ công khai của người dùng / creator theo userId.
     */
    @Transactional(readOnly = true)
    public ProfileResponse getPublicProfile(Long userId) {
        UserProfile profile = profileRepository.findByUserId(userId)
                .orElseThrow(ProfileNotFoundException::new);
        return profileMapper.toResponse(profile);
    }

    /**
     * Cập nhật các thông tin hồ sơ được phép của người dùng hiện tại.
     */
    @Transactional
    public ProfileResponse updateCurrentProfile(String email, UpdateProfileRequest request) {
        return updateCurrentProfile(email, request, null);
    }

    /**
     * Cập nhật hồ sơ và thay avatar Cloudinary trong cùng một luồng nghiệp vụ.
     */
    @Transactional
    public ProfileResponse updateCurrentProfile(String email, UpdateProfileRequest request, MultipartFile avatar) {
        UserProfile profile = findByEmail(email);
        String username = request.username().trim().toLowerCase(Locale.ROOT);
        if (!username.equalsIgnoreCase(profile.getUsername())
                && profileRepository.existsByUsernameIgnoreCaseAndUserIdNot(username, profile.getUserId())) {
            throw new UsernameAlreadyExistsException();
        }

        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);
        profile.update(
                username,
                request.displayName().trim(),
                normalizeOptional(request.bio()),
                request.dateOfBirth(),
                normalizeCountryCode(request.countryCode()),
                now
        );

        if (avatar != null && !avatar.isEmpty()) {
            String oldPublicId = profile.getAvatarPublicId();
            StoredMediaResponse uploadedAvatar = cloudMediaService.uploadAvatar(avatar, profile.getUserId());
            profile.updateAvatar(uploadedAvatar.publicId(), uploadedAvatar.secureUrl(), now);
            registerMediaCleanup(oldPublicId, uploadedAvatar.publicId());
        }
        profileRepository.saveAndFlush(profile);
        return profileMapper.toResponse(profile);
    }

    /**
     * Đổi mật khẩu cho người dùng hiện tại (UC-12 / TC-15).
     */
    @Transactional
    public void changePassword(String email, ChangePasswordRequest request) {
        if (!request.newPassword().equals(request.confirmPassword())) {
            throw new BadRequestOperationException("PASSWORDS_DO_NOT_MATCH", "Mật khẩu xác nhận không khớp với mật khẩu mới");
        }

        UserProfile profile = findByEmail(email);
        AppUser user = profile.getUser();

        if (!passwordEncoder.matches(request.currentPassword(), user.getPasswordHash())) {
            throw new BadRequestOperationException("INVALID_CURRENT_PASSWORD", "Mật khẩu hiện tại không chính xác");
        }

        if (passwordEncoder.matches(request.newPassword(), user.getPasswordHash())) {
            throw new BadRequestOperationException("SAME_PASSWORD", "Mật khẩu mới không được trùng với mật khẩu hiện tại");
        }

        user.changePassword(passwordEncoder.encode(request.newPassword()), LocalDateTime.now(ZoneOffset.UTC));
        profileRepository.saveAndFlush(profile);
    }

    private UserProfile findByEmail(String email) {
        return profileRepository.findByUser_EmailIgnoreCase(email)
                .orElseThrow(ProfileNotFoundException::new);
    }

    private String normalizeOptional(String value) {
        if (value == null || value.isBlank()) return null;
        return value.trim();
    }

    private String normalizeCountryCode(String countryCode) {
        String normalized = normalizeOptional(countryCode);
        return normalized == null ? null : normalized.toUpperCase(Locale.ROOT);
    }

    /**
     * Chỉ xóa ảnh cũ sau commit; nếu rollback thì dọn ảnh mới vừa tải lên.
     */
    private void registerMediaCleanup(String oldPublicId, String newPublicId) {
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
            @Override
            public void afterCompletion(int status) {
                if (status == STATUS_COMMITTED) {
                    cloudMediaService.deleteImageQuietly(oldPublicId);
                } else {
                    cloudMediaService.deleteImageQuietly(newPublicId);
                }
            }
        });
    }
}
