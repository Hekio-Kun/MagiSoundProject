package group03.magisound.admin.service;

import group03.magisound.admin.dto.response.*;
import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.entity.UserStatus;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.GenreRepository;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.repository.ContentReportRepository;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Service tổng hợp số liệu thống kê hệ thống phục vụ Admin Dashboard (UC-22: View System Statistics).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminStatisticsService {

    private final AppUserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final TrackRepository trackRepository;
    private final GenreRepository genreRepository;
    private final TrackSubmissionRepository trackSubmissionRepository;
    private final ContentReportRepository contentReportRepository;

    /**
     * Thu thập và tính toán số liệu thống kê hệ thống theo khoảng thời gian chỉ định.
     */
    @Transactional(readOnly = true)
    public SystemStatisticsResponse getSystemStatistics(String period) {
        String normalizedPeriod = normalizePeriod(period);
        int days = getDaysForPeriod(normalizedPeriod);

        LocalDateTime now = LocalDateTime.now(ZoneOffset.UTC);
        LocalDateTime periodStart = now.minusDays(days);
        LocalDateTime prevPeriodStart = now.minusDays(days * 2L);
        LocalDateTime prevPeriodEnd = periodStart;

        long dbStartMs = System.currentTimeMillis();

        // 1. Thống kê người dùng
        long totalUsers = userRepository.countByDeletedAtIsNull();
        long activeUsers = userRepository.countByStatusAndDeletedAtIsNull(UserStatus.ACTIVE);
        long newUsersInPeriod = userRepository.countByCreatedAtBetweenAndDeletedAtIsNull(periodStart, now);
        long newUsersInPrevPeriod = userRepository.countByCreatedAtBetweenAndDeletedAtIsNull(prevPeriodStart, prevPeriodEnd);

        double userGrowthPercentage = calculateGrowthPercentage(newUsersInPeriod, newUsersInPrevPeriod);

        // 2. Thống kê danh mục bài hát & tương tác
        long publishedTracks = trackRepository.countByPublicationStatus(TrackPublicationStatus.PUBLISHED);
        long newTracksInPeriod = trackRepository.countByPublicationStatusAndCreatedAtAfter(TrackPublicationStatus.PUBLISHED, periodStart);
        Long totalPlaysVal = trackRepository.sumPlayCountCache();
        long totalPlays = totalPlaysVal != null ? totalPlaysVal : 0L;
        Long totalCreatorsVal = trackRepository.countDistinctUploaders();
        long totalCreators = totalCreatorsVal != null ? totalCreatorsVal : 0L;

        // 3. Thống kê kiểm duyệt & báo cáo
        long pendingReviews = trackSubmissionRepository.countByStatus(SubmissionStatus.PENDING);
        long pendingReports = contentReportRepository.countByStatusIgnoreCase("PENDING");
        long activeGenres = genreRepository.countByIsActiveTrue();

        long dbLatencyMs = Math.max(5, System.currentTimeMillis() - dbStartMs);

        MetricOverviewResponse overview = new MetricOverviewResponse(
                totalUsers,
                activeUsers,
                newUsersInPeriod,
                userGrowthPercentage,
                publishedTracks,
                newTracksInPeriod,
                totalPlays,
                pendingReviews,
                pendingReports,
                activeGenres,
                totalCreators
        );

        List<TopTrackStatisticResponse> topTracks = getTopTracks(10);
        List<DailyGrowthStatisticResponse> userGrowth = getDailyGrowth(periodStart, now, days);
        RoleDistributionResponse roleDistribution = getRoleDistribution(totalUsers, totalCreators);
        List<RecentAccountStatisticResponse> recentAccounts = getRecentAccounts(5);

        SystemHealthResponse health = new SystemHealthResponse(
                "Operational",
                "Connected",
                "Operational (Internal Storage)",
                "Active",
                12,
                (int) dbLatencyMs,
                1,
                "99.98%"
        );

        return new SystemStatisticsResponse(
                overview,
                topTracks,
                userGrowth,
                roleDistribution,
                recentAccounts,
                health,
                normalizedPeriod,
                now
        );
    }

    private String normalizePeriod(String period) {
        if (period == null || period.isBlank()) return "7d";
        String trimmed = period.trim().toLowerCase(Locale.ROOT);
        return switch (trimmed) {
            case "30d" -> "30d";
            case "90d" -> "90d";
            default -> "7d";
        };
    }

    private int getDaysForPeriod(String period) {
        return switch (period) {
            case "30d" -> 30;
            case "90d" -> 90;
            default -> 7;
        };
    }

    private double calculateGrowthPercentage(long current, long previous) {
        if (previous == 0) {
            return current > 0 ? 100.0 : 0.0;
        }
        double change = (double) (current - previous) / previous * 100.0;
        return Math.round(change * 10.0) / 10.0;
    }

    private List<TopTrackStatisticResponse> getTopTracks(int limit) {
        List<Track> tracks = trackRepository.findTopTracksByPlayCount(
                TrackPublicationStatus.PUBLISHED, PageRequest.of(0, limit)
        );

        if (tracks.isEmpty()) {
            return Collections.emptyList();
        }

        Set<Long> uploaderIds = tracks.stream()
                .map(Track::getUploaderUserId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Long, String> uploaderNameMap = new HashMap<>();
        for (Long uid : uploaderIds) {
            userProfileRepository.findByUserId(uid)
                    .ifPresent(p -> uploaderNameMap.put(uid, p.getDisplayName() != null ? p.getDisplayName() : p.getUsername()));
        }

        return tracks.stream().map(track -> {
            String uploaderName = track.getUploaderUserId() != null
                    ? uploaderNameMap.getOrDefault(track.getUploaderUserId(), "Unknown Artist")
                    : "Unknown Artist";
            String genreName = track.getGenre() != null ? track.getGenre().getName() : "Unassigned";
            long playCount = track.getPlayCountCache() != null ? track.getPlayCountCache() : 0L;

            return new TopTrackStatisticResponse(
                    track.getId(),
                    track.getTitle(),
                    uploaderName,
                    genreName,
                    playCount,
                    track.getCoverUrl(),
                    track.getDurationMs()
            );
        }).toList();
    }

    private List<DailyGrowthStatisticResponse> getDailyGrowth(LocalDateTime start, LocalDateTime end, int days) {
        List<AppUser> usersInPeriod = userRepository.findUsersCreatedSince(start);

        Map<LocalDate, Long> countByDate = new HashMap<>();
        for (AppUser u : usersInPeriod) {
            if (u.getCreatedAt() != null) {
                LocalDate date = u.getCreatedAt().toLocalDate();
                countByDate.put(date, countByDate.getOrDefault(date, 0L) + 1);
            }
        }

        List<DailyGrowthStatisticResponse> result = new ArrayList<>();
        LocalDate startDate = start.toLocalDate();
        LocalDate endDate = end.toLocalDate();

        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        if (days == 7) {
            for (int i = 6; i >= 0; i--) {
                LocalDate d = endDate.minusDays(i);
                String label = d.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.ENGLISH);
                long count = countByDate.getOrDefault(d, 0L);
                result.add(new DailyGrowthStatisticResponse(label, d.format(dateFmt), count));
            }
        } else {
            for (LocalDate d = startDate; !d.isAfter(endDate); d = d.plusDays(1)) {
                String label = d.format(DateTimeFormatter.ofPattern("MM/dd"));
                long count = countByDate.getOrDefault(d, 0L);
                result.add(new DailyGrowthStatisticResponse(label, d.format(dateFmt), count));
            }
        }

        return result;
    }

    private RoleDistributionResponse getRoleDistribution(long totalUsers, long totalCreators) {
        long staffs = userRepository.countByRole_CodeIgnoreCase("STAFF");
        long admins = userRepository.countByRole_CodeIgnoreCase("ADMIN");

        long listeners = Math.max(0, totalUsers - totalCreators - staffs - admins);
        double listenerPercentage = totalUsers > 0
                ? Math.round(((double) listeners / totalUsers * 100.0) * 10.0) / 10.0
                : 0.0;
        double creatorPercentage = totalUsers > 0
                ? Math.round(((double) totalCreators / totalUsers * 100.0) * 10.0) / 10.0
                : 0.0;

        return new RoleDistributionResponse(
                listeners,
                totalCreators,
                staffs,
                admins,
                listenerPercentage,
                creatorPercentage
        );
    }

    private List<RecentAccountStatisticResponse> getRecentAccounts(int limit) {
        List<AppUser> recentUsers = userRepository.findTop5ByDeletedAtIsNullOrderByCreatedAtDesc();
        if (recentUsers.isEmpty()) {
            return Collections.emptyList();
        }

        Set<Long> userIds = recentUsers.stream().map(AppUser::getId).collect(Collectors.toSet());
        Map<Long, UserProfile> profileMap = userProfileRepository.findAllById(userIds).stream()
                .collect(Collectors.toMap(UserProfile::getUserId, p -> p, (a, b) -> a));

        return recentUsers.stream().map(u -> {
            UserProfile profile = profileMap.get(u.getId());
            String displayName = profile != null && profile.getDisplayName() != null && !profile.getDisplayName().isBlank()
                    ? profile.getDisplayName()
                    : extractNameFromEmail(u.getEmail());

            String initials = getInitials(displayName);

            String roleCode = u.getRole() != null ? u.getRole().getCode() : "LISTENER";
            String role = switch (roleCode.toUpperCase(Locale.ROOT)) {
                case "ADMIN" -> "Admin";
                case "STAFF" -> "Staff";
                default -> (trackRepository.countByUploaderUserId(u.getId()) > 0) ? "Creator" : "Listener";
            };

            String status = u.getStatus() == UserStatus.ACTIVE ? "Verified" : "Pending";
            String avatarUrl = profile != null ? profile.getAvatarUrl() : null;

            return new RecentAccountStatisticResponse(
                    u.getId(),
                    u.getEmail(),
                    displayName,
                    role,
                    status,
                    u.getCreatedAt(),
                    initials,
                    avatarUrl
            );
        }).toList();
    }

    private String extractNameFromEmail(String email) {
        if (email == null) return "User";
        int atIndex = email.indexOf('@');
        return atIndex > 0 ? email.substring(0, atIndex) : email;
    }

    private String getInitials(String name) {
        if (name == null || name.isBlank()) return "MS";
        String[] parts = name.trim().split("\\s+");
        if (parts.length == 1) {
            return parts[0].substring(0, Math.min(2, parts[0].length())).toUpperCase(Locale.ROOT);
        }
        return (parts[0].substring(0, 1) + parts[parts.length - 1].substring(0, 1)).toUpperCase(Locale.ROOT);
    }
}
