package group03.magisound.authentication.service;

import group03.magisound.authentication.dto.request.UpdateProfileRequest;
import group03.magisound.authentication.dto.response.ProfileResponse;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.exception.ProfileNotFoundException;
import group03.magisound.authentication.exception.UsernameAlreadyExistsException;
import group03.magisound.authentication.mapper.ProfileMapper;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.media.service.CloudMediaService;
import group03.magisound.media.dto.response.StoredMediaResponse;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ProfileServiceTest {
    @Mock private UserProfileRepository profileRepository;
    @Mock private ProfileMapper profileMapper;
    @Mock private CloudMediaService cloudMediaService;
    @Mock private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @Test
    void getCurrentProfileReturnsMappedAuthenticatedProfile() {
        UserProfile profile = org.mockito.Mockito.mock(UserProfile.class);
        ProfileResponse expected = response("listener");
        when(profileRepository.findByUser_EmailIgnoreCase("listener@example.com"))
                .thenReturn(Optional.of(profile));
        when(profileMapper.toResponse(profile)).thenReturn(expected);

        ProfileResponse result = service().getCurrentProfile("listener@example.com");

        assertSame(expected, result);
    }

    @Test
    void getCurrentProfileRejectsMissingProfile() {
        when(profileRepository.findByUser_EmailIgnoreCase("missing@example.com"))
                .thenReturn(Optional.empty());

        assertThrows(ProfileNotFoundException.class,
                () -> service().getCurrentProfile("missing@example.com"));
    }

    @Test
    void updateCurrentProfileNormalizesAndUpdatesAllowedFields() {
        UserProfile profile = org.mockito.Mockito.mock(UserProfile.class);
        UpdateProfileRequest request = new UpdateProfileRequest(
                " New.Listener ", " New Listener ", "  Music lover  ",
                LocalDate.of(2000, 1, 2), "vn");
        ProfileResponse expected = response("new.listener");
        when(profile.getUsername()).thenReturn("old.listener");
        when(profile.getUserId()).thenReturn(7L);
        when(profileRepository.findByUser_EmailIgnoreCase("listener@example.com"))
                .thenReturn(Optional.of(profile));
        when(profileRepository.existsByUsernameIgnoreCaseAndUserIdNot("new.listener", 7L))
                .thenReturn(false);
        when(profileMapper.toResponse(profile)).thenReturn(expected);

        ProfileResponse result = service().updateCurrentProfile("listener@example.com", request);

        assertSame(expected, result);
        verify(profile).update(eq("new.listener"), eq("New Listener"), eq("Music lover"),
                eq(LocalDate.of(2000, 1, 2)), eq("VN"), any(LocalDateTime.class));
        verify(profileRepository).saveAndFlush(profile);
    }

    @Test
    void updateCurrentProfileRejectsUsernameOwnedByAnotherUser() {
        UserProfile profile = org.mockito.Mockito.mock(UserProfile.class);
        UpdateProfileRequest request = new UpdateProfileRequest(
                "taken", "Listener", null, null, null);
        when(profile.getUsername()).thenReturn("current");
        when(profile.getUserId()).thenReturn(7L);
        when(profileRepository.findByUser_EmailIgnoreCase("listener@example.com"))
                .thenReturn(Optional.of(profile));
        when(profileRepository.existsByUsernameIgnoreCaseAndUserIdNot("taken", 7L))
                .thenReturn(true);

        assertThrows(UsernameAlreadyExistsException.class,
                () -> service().updateCurrentProfile("listener@example.com", request));

        verify(profile, never()).update(any(), any(), any(), any(), any(), any());
    }

    @Test
    void updateCurrentProfileReplacesAvatarAndDeletesOldMediaAfterCommit() {
        UserProfile profile = org.mockito.Mockito.mock(UserProfile.class);
        UpdateProfileRequest request = new UpdateProfileRequest("listener", "Listener", null, null, null);
        MockMultipartFile avatar = new MockMultipartFile(
                "avatar", "avatar.png", "image/png", new byte[]{(byte) 0x89, 0x50, 0x4E, 0x47});
        when(profile.getUsername()).thenReturn("listener");
        when(profile.getUserId()).thenReturn(7L);
        when(profile.getAvatarPublicId()).thenReturn("soundwave/avatars/old");
        when(profileRepository.findByUser_EmailIgnoreCase("listener@example.com"))
                .thenReturn(Optional.of(profile));
        when(cloudMediaService.uploadAvatar(avatar, 7L))
                .thenReturn(new StoredMediaResponse("soundwave/avatars/new", "https://cdn.example.com/new.png"));

        TransactionSynchronizationManager.initSynchronization();
        try {
            service().updateCurrentProfile("listener@example.com", request, avatar);
            TransactionSynchronizationManager.getSynchronizations()
                    .forEach(synchronization -> synchronization.afterCompletion(TransactionSynchronization.STATUS_COMMITTED));
        } finally {
            TransactionSynchronizationManager.clearSynchronization();
        }

        verify(profile).updateAvatar(eq("soundwave/avatars/new"), eq("https://cdn.example.com/new.png"), any());
        verify(profileRepository).saveAndFlush(profile);
        verify(cloudMediaService).deleteImageQuietly("soundwave/avatars/old");
    }

    @Test
    void changePasswordSuccess() {
        UserProfile profile = org.mockito.Mockito.mock(UserProfile.class);
        group03.magisound.authentication.entity.AppUser user = org.mockito.Mockito.mock(group03.magisound.authentication.entity.AppUser.class);
        when(profile.getUser()).thenReturn(user);
        when(user.getPasswordHash()).thenReturn("hashedOldPassword");
        when(profileRepository.findByUser_EmailIgnoreCase("listener@example.com"))
                .thenReturn(Optional.of(profile));
        when(passwordEncoder.matches("OldPassword@123", "hashedOldPassword")).thenReturn(true);
        when(passwordEncoder.matches("NewPassword@123", "hashedOldPassword")).thenReturn(false);
        when(passwordEncoder.encode("NewPassword@123")).thenReturn("hashedNewPassword");

        group03.magisound.authentication.dto.request.ChangePasswordRequest request =
                new group03.magisound.authentication.dto.request.ChangePasswordRequest(
                        "OldPassword@123", "NewPassword@123", "NewPassword@123");

        service().changePassword("listener@example.com", request);

        verify(user).changePassword(eq("hashedNewPassword"), any());
        verify(profileRepository).saveAndFlush(profile);
    }

    @Test
    void changePasswordThrowsWhenMismatchConfirm() {
        group03.magisound.authentication.dto.request.ChangePasswordRequest request =
                new group03.magisound.authentication.dto.request.ChangePasswordRequest(
                        "OldPassword@123", "NewPassword@123", "Mismatch@123");

        assertThrows(group03.magisound.exception.BadRequestOperationException.class,
                () -> service().changePassword("listener@example.com", request));
    }

    private ProfileService service() {
        return new ProfileService(profileRepository, profileMapper, cloudMediaService, passwordEncoder);
    }

    private ProfileResponse response(String username) {
        return new ProfileResponse(
                7L, "listener@example.com", username, "Listener", null, null,
                null, "VN", "LISTENER", LocalDateTime.now(), LocalDateTime.now());
    }
}
