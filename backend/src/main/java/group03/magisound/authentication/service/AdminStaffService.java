package group03.magisound.authentication.service;

import group03.magisound.authentication.dto.request.CreateStaffRequest;
import group03.magisound.authentication.dto.request.DeactivateStaffRequest;
import group03.magisound.authentication.dto.response.*;
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
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;

/**
 * Service xử lý các nghiệp vụ quản trị danh bạ tài khoản Staff dành cho Admin (UC-20: Manage Staff Accounts).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminStaffService {

    private final AppUserRepository userRepository;
    private final RoleRepository roleRepository;
    private final UserProfileRepository userProfileRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final ModerationService moderationService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationMailService mailService;

    @Value("${app.staff.login-url:http://127.0.0.1:5173/#/staff/login}")
    private String staffLoginUrl;

    /**
     * Lấy danh bạ tài khoản nhân viên kiểm duyệt có tìm kiếm, lọc theo trạng thái và phân trang (UC-20.1).
     */
    @Transactional(readOnly = true)
    public StaffDirectoryPageResponse getStaffDirectory(String search, String status, String role, Pageable pageable) {
        String normalizedSearch = (search != null && !search.isBlank()) ? search.trim().toLowerCase(Locale.ROOT) : null;
        UserStatus statusFilter = null;
        if (status != null && !status.isBlank() && !"ALL".equalsIgnoreCase(status.trim())) {
            try {
                if ("ACTIVE".equalsIgnoreCase(status.trim())) {
                    statusFilter = UserStatus.ACTIVE;
                } else if ("INACTIVE".equalsIgnoreCase(status.trim()) || "BANNED".equalsIgnoreCase(status.trim())) {
                    statusFilter = UserStatus.BANNED;
                } else {
                    statusFilter = UserStatus.valueOf(status.trim().toUpperCase(Locale.ROOT));
                }
            } catch (IllegalArgumentException ignored) {}
        }

        Page<AppUser> page = userRepository.findStaffUsers(normalizedSearch, statusFilter, pageable);

        List<Long> staffIds = page.getContent().stream().map(AppUser::getId).toList();
        Map<Long, Long> moderationCounts = moderationService.getModerationCountsByReviewerIds(staffIds);

        Map<Long, UserProfile> profileMap = new HashMap<>();
        for (Long id : staffIds) {
            userProfileRepository.findByUserId(id).ifPresent(p -> profileMap.put(id, p));
        }

        Page<StaffSummaryResponse> responsePage = page.map(staff -> {
            UserProfile profile = profileMap.get(staff.getId());
            String fullName = profile != null && profile.getDisplayName() != null ? profile.getDisplayName() : staff.getEmail();
            String avatarUrl = profile != null ? profile.getAvatarUrl() : null;
            String roleCode = staff.getRole() != null ? staff.getRole().getCode() : "STAFF";
            String roleName = staff.getRole() != null ? staff.getRole().getName() : "Staff";
            String statusStr = (staff.getStatus() == UserStatus.BANNED) ? "INACTIVE" : staff.getStatus().name();

            return new StaffSummaryResponse(
                    staff.getId(),
                    staff.getEmail(),
                    fullName,
                    roleCode,
                    roleName,
                    statusStr,
                    avatarUrl,
                    staff.getLastLoginAt(),
                    staff.getCreatedAt(),
                    moderationCounts.getOrDefault(staff.getId(), 0L),
                    0L
            );
        });

        return StaffDirectoryPageResponse.of(responsePage);
    }

    /**
     * Tạo mới tài khoản nhân viên kiểm duyệt (UC-20.2: Create Staff Account).
     */
    @Transactional
    public CreateStaffResponse createStaff(CreateStaffRequest request) {
        String normalizedEmail = request.email().trim().toLowerCase(Locale.ROOT);
        String trimmedFullName = request.fullName().trim();

        if (userRepository.existsByEmailIgnoreCase(normalizedEmail)) {
            throw new EmailAlreadyExistsException("This email address is already in use by another account.");
        }

        Role staffRole = roleRepository.findByCode("STAFF")
                .orElseThrow(() -> new ResourceNotFoundException("ROLE_NOT_FOUND", "STAFF role could not be found"));

        String rawPassword;
        if (request.password() != null && !request.password().isBlank()) {
            rawPassword = request.password().trim();
        } else {
            rawPassword = generateStandardizedStaffPassword();
        }

        String encodedPassword = passwordEncoder.encode(rawPassword);

        AppUser newStaff = new AppUser(staffRole, normalizedEmail, encodedPassword);
        newStaff.verifyEmail(LocalDateTime.now(ZoneOffset.UTC));
        AppUser savedStaff = userRepository.save(newStaff);

        String username = normalizedEmail.contains("@") ? normalizedEmail.substring(0, normalizedEmail.indexOf('@')) : "staff_" + savedStaff.getId();
        if (userProfileRepository.existsByUsername(username)) {
            username = username + "_" + savedStaff.getId();
        }

        UserProfile profile = new UserProfile(savedStaff, username, trimmedFullName);
        userProfileRepository.save(profile);

        boolean emailDispatched = false;
        try {
            mailService.sendStaffCredentials(normalizedEmail, trimmedFullName, rawPassword, staffLoginUrl);
            emailDispatched = true;
        } catch (Exception ex) {
            log.error("Failed to send initial credential email to new staff: {}", normalizedEmail, ex);
        }

        log.info("Successfully created new Staff account: id={}, email='{}', name='{}', emailDispatched={}",
                savedStaff.getId(), normalizedEmail, trimmedFullName, emailDispatched);

        return new CreateStaffResponse(
                savedStaff.getId(),
                savedStaff.getEmail(),
                trimmedFullName,
                staffRole.getCode(),
                staffRole.getName(),
                "ACTIVE",
                rawPassword,
                emailDispatched,
                savedStaff.getCreatedAt()
        );
    }

    /**
     * Vô hiệu hóa tài khoản nhân viên kiểm duyệt (UC-20.3: Deactivate Staff Account).
     */
    @Transactional
    public DeactivateStaffResponse deactivateStaff(Long staffId, DeactivateStaffRequest request) {
        AppUser staff = userRepository.findById(staffId)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff account not found with ID: " + staffId));

        if (staff.getRole() != null && "ADMIN".equalsIgnoreCase(staff.getRole().getCode())) {
            throw new ForbiddenOperationException("FORBIDDEN", "Admin accounts cannot be deactivated via staff management.");
        }

        if (staff.getStatus() == UserStatus.BANNED) {
            throw new ConflictOperationException("This staff account is already inactive.");
        }

        String trimmedReason = request.reason().trim();
        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);

        staff.deactivate();
        AppUser updatedStaff = userRepository.save(staff);

        int revokedTokens = refreshTokenRepository.revokeAllActiveByUserId(staffId, now);

        UserProfile profile = userProfileRepository.findByUserId(staffId).orElse(null);
        String fullName = profile != null && profile.getDisplayName() != null ? profile.getDisplayName() : updatedStaff.getEmail();

        log.warn("Staff account deactivated by Admin: staffId={}, email='{}', revokedTokens={}, reason='{}', timestamp={}",
                staffId, updatedStaff.getEmail(), revokedTokens, trimmedReason, now);

        return new DeactivateStaffResponse(
                updatedStaff.getId(),
                updatedStaff.getEmail(),
                fullName,
                updatedStaff.getRole() != null ? updatedStaff.getRole().getCode() : "STAFF",
                "INACTIVE",
                trimmedReason,
                now
        );
    }

    /**
     * Lấy toàn bộ lịch sử hoạt động kiểm duyệt của một nhân viên (UC-20.4: View Staff Moderation Activity).
     */
    @Transactional(readOnly = true)
    public StaffModerationActivityResponse getStaffModerationActivity(Long staffId) {
        AppUser staff = userRepository.findById(staffId)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff account not found with ID: " + staffId));

        UserProfile profile = userProfileRepository.findByUserId(staffId).orElse(null);
        String fullName = profile != null && profile.getDisplayName() != null ? profile.getDisplayName() : staff.getEmail();

        ModerationActivityBundleResponse bundle = moderationService.getModerationActivitiesByReviewerId(staffId);

        String statusStr = (staff.getStatus() == UserStatus.BANNED) ? "INACTIVE" : staff.getStatus().name();

        return new StaffModerationActivityResponse(
                staff.getId(),
                fullName,
                staff.getEmail(),
                staff.getRole() != null ? staff.getRole().getCode() : "STAFF",
                staff.getRole() != null ? staff.getRole().getName() : "Staff",
                statusStr,
                bundle.totalTracksModerated(),
                bundle.totalReportsResolved(),
                bundle.trackReviews(),
                bundle.reportResolutions()
        );
    }

    private String generateStandardizedStaffPassword() {
        String upper = "ABCDEFGHJKLMNPQRSTUVWXYZ";
        String lower = "abcdefghjkmnpqrstuvwxyz";
        String digits = "23456789";
        String alphanum = upper + lower + digits;

        SecureRandom random = new SecureRandom();
        StringBuilder body = new StringBuilder(6);
        body.append(upper.charAt(random.nextInt(upper.length())));
        body.append(lower.charAt(random.nextInt(lower.length())));
        body.append(digits.charAt(random.nextInt(digits.length())));

        for (int i = 3; i < 6; i++) {
            body.append(alphanum.charAt(random.nextInt(alphanum.length())));
        }

        List<Character> bodyChars = new ArrayList<>();
        for (char c : body.toString().toCharArray()) {
            bodyChars.add(c);
        }
        Collections.shuffle(bodyChars, random);

        StringBuilder bodyShuffled = new StringBuilder();
        for (char c : bodyChars) {
            bodyShuffled.append(c);
        }

        int suffixDigits = 10 + random.nextInt(90);

        return "MS@" + bodyShuffled + "!" + suffixDigits;
    }
}
