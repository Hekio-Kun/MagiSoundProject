package group03.magisound.authentication.service;

import group03.magisound.authentication.dto.request.CreateStaffRequest;
import group03.magisound.authentication.dto.request.DeactivateStaffRequest;
import group03.magisound.authentication.dto.response.CreateStaffResponse;
import group03.magisound.authentication.dto.response.DeactivateStaffResponse;
import group03.magisound.authentication.dto.response.StaffDirectoryPageResponse;
import group03.magisound.authentication.dto.response.StaffModerationActivityResponse;
import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.Role;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.entity.UserStatus;
import group03.magisound.authentication.exception.EmailAlreadyExistsException;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.RefreshTokenRepository;
import group03.magisound.authentication.repository.RoleRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.exception.ConflictOperationException;
import group03.magisound.exception.ForbiddenOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.moderation.dto.response.ModerationActivityBundleResponse;
import group03.magisound.moderation.service.ModerationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdminStaffServiceTest {

    @Mock
    private AppUserRepository userRepository;

    @Mock
    private RoleRepository roleRepository;

    @Mock
    private UserProfileRepository userProfileRepository;

    @Mock
    private RefreshTokenRepository refreshTokenRepository;

    @Mock
    private ModerationService moderationService;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private AuthenticationMailService mailService;

    @InjectMocks
    private AdminStaffService adminStaffService;

    private Role staffRole;
    private AppUser staffUser;
    private UserProfile staffProfile;

    @BeforeEach
    void setUp() {
        staffRole = new Role("STAFF", "Moderation Staff", "Staff role");
        ReflectionTestUtils.setField(staffRole, "id", (short) 2);

        staffUser = new AppUser(staffRole, "staff@magisound.com", "encoded_password");
        ReflectionTestUtils.setField(staffUser, "id", 20L);
        staffUser.activate();

        staffProfile = new UserProfile(staffUser, "staff_user", "Staff Member");
        ReflectionTestUtils.setField(staffProfile, "userId", 20L);
    }

    @Test
    @DisplayName("getStaffDirectory - Returns paginated staff directory with moderation counts (UC-20.1)")
    void getStaffDirectory_Success() {
        Pageable pageable = PageRequest.of(0, 10);
        when(userRepository.findStaffUsers(any(), any(), eq(pageable)))
                .thenReturn(new PageImpl<>(List.of(staffUser), pageable, 1));
        when(moderationService.getModerationCountsByReviewerIds(List.of(20L)))
                .thenReturn(Map.of(20L, 15L));
        when(userProfileRepository.findByUserId(20L)).thenReturn(Optional.of(staffProfile));

        StaffDirectoryPageResponse response = adminStaffService.getStaffDirectory(null, "ACTIVE", "STAFF", pageable);

        assertNotNull(response);
        assertEquals(1, response.content().size());
        assertEquals("staff@magisound.com", response.content().get(0).email());
        assertEquals("Staff Member", response.content().get(0).fullName());
        assertEquals(15L, response.content().get(0).totalTracksModerated());
    }

    @Test
    @DisplayName("createStaff - Successfully creates staff and dispatches email (UC-20.2)")
    void createStaff_Success() {
        CreateStaffRequest request = new CreateStaffRequest("New Moderator", "newmod@magisound.com");

        when(userRepository.existsByEmailIgnoreCase("newmod@magisound.com")).thenReturn(false);
        when(roleRepository.findByCode("STAFF")).thenReturn(Optional.of(staffRole));
        when(passwordEncoder.encode(any())).thenReturn("hashed_generated_pwd");
        when(userRepository.save(any(AppUser.class))).thenAnswer(inv -> {
            AppUser u = inv.getArgument(0);
            ReflectionTestUtils.setField(u, "id", 30L);
            return u;
        });

        CreateStaffResponse response = adminStaffService.createStaff(request);

        assertNotNull(response);
        assertEquals(30L, response.id());
        assertEquals("newmod@magisound.com", response.email());
        assertEquals("New Moderator", response.fullName());
        assertEquals("STAFF", response.roleCode());
        assertNotNull(response.temporaryPassword());
        assertTrue(response.temporaryPassword().startsWith("MS@"));

        verify(mailService, times(1)).sendStaffCredentials(eq("newmod@magisound.com"), eq("New Moderator"), any(), any());
    }

    @Test
    @DisplayName("createStaff - Throws EmailAlreadyExistsException when email taken")
    void createStaff_EmailExists() {
        CreateStaffRequest request = new CreateStaffRequest("Mod", "staff@magisound.com");
        when(userRepository.existsByEmailIgnoreCase("staff@magisound.com")).thenReturn(true);

        assertThrows(EmailAlreadyExistsException.class, () -> adminStaffService.createStaff(request));
        verify(userRepository, never()).save(any());
    }

    @Test
    @DisplayName("deactivateStaff - Successfully deactivates staff and revokes active tokens (UC-20.3)")
    void deactivateStaff_Success() {
        when(userRepository.findById(20L)).thenReturn(Optional.of(staffUser));
        when(userRepository.save(any(AppUser.class))).thenReturn(staffUser);
        when(userProfileRepository.findByUserId(20L)).thenReturn(Optional.of(staffProfile));

        DeactivateStaffRequest request = new DeactivateStaffRequest("Violation of moderation guidelines");
        DeactivateStaffResponse response = adminStaffService.deactivateStaff(20L, request);

        assertNotNull(response);
        assertEquals("INACTIVE", response.status());
        assertEquals("Violation of moderation guidelines", response.reason());
        assertEquals(UserStatus.BANNED, staffUser.getStatus());

        verify(refreshTokenRepository, times(1)).revokeAllActiveByUserId(eq(20L), any());
    }

    @Test
    @DisplayName("deactivateStaff - Throws ConflictOperationException if staff already inactive")
    void deactivateStaff_AlreadyInactive() {
        staffUser.deactivate();
        when(userRepository.findById(20L)).thenReturn(Optional.of(staffUser));

        DeactivateStaffRequest request = new DeactivateStaffRequest("Violation");
        assertThrows(ConflictOperationException.class, () -> adminStaffService.deactivateStaff(20L, request));
    }

    @Test
    @DisplayName("getStaffModerationActivity - Returns moderation activity bundle (UC-20.4)")
    void getStaffModerationActivity_Success() {
        when(userRepository.findById(20L)).thenReturn(Optional.of(staffUser));
        when(userProfileRepository.findByUserId(20L)).thenReturn(Optional.of(staffProfile));
        when(moderationService.getModerationActivitiesByReviewerId(20L))
                .thenReturn(new ModerationActivityBundleResponse(5L, 2L, Collections.emptyList(), Collections.emptyList()));

        StaffModerationActivityResponse response = adminStaffService.getStaffModerationActivity(20L);

        assertNotNull(response);
        assertEquals(20L, response.staffId());
        assertEquals(5L, response.totalTracksModerated());
        assertEquals(2L, response.totalReportsResolved());
    }
}
