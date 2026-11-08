package group03.magisound.admin.service;

import group03.magisound.admin.dto.response.SystemStatisticsResponse;
import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserStatus;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.GenreRepository;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.repository.ContentReportRepository;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Pageable;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AdminStatisticsServiceTest {

    @Mock
    private AppUserRepository userRepository;

    @Mock
    private UserProfileRepository userProfileRepository;

    @Mock
    private TrackRepository trackRepository;

    @Mock
    private GenreRepository genreRepository;

    @Mock
    private TrackSubmissionRepository trackSubmissionRepository;

    @Mock
    private ContentReportRepository contentReportRepository;

    @InjectMocks
    private AdminStatisticsService adminStatisticsService;

    @Test
    void getSystemStatistics_Default7d_ShouldReturnAggregatedMetrics() {
        when(userRepository.countByDeletedAtIsNull()).thenReturn(100L);
        when(userRepository.countByStatusAndDeletedAtIsNull(UserStatus.ACTIVE)).thenReturn(85L);
        when(userRepository.countByCreatedAtBetweenAndDeletedAtIsNull(any(), any())).thenReturn(10L);

        when(trackRepository.countByPublicationStatus(TrackPublicationStatus.PUBLISHED)).thenReturn(50L);
        when(trackRepository.countByPublicationStatusAndCreatedAtAfter(eq(TrackPublicationStatus.PUBLISHED), any())).thenReturn(5L);
        when(trackRepository.sumPlayCountCache()).thenReturn(12000L);
        when(trackRepository.countDistinctUploaders()).thenReturn(15L);

        when(trackSubmissionRepository.countByStatus(SubmissionStatus.PENDING)).thenReturn(3L);
        when(contentReportRepository.countByStatusIgnoreCase("PENDING")).thenReturn(2L);
        when(genreRepository.countByIsActiveTrue()).thenReturn(8L);

        when(userRepository.countByRole_CodeIgnoreCase("STAFF")).thenReturn(4L);
        when(userRepository.countByRole_CodeIgnoreCase("ADMIN")).thenReturn(1L);

        Genre mockGenre = new Genre("Ambient", "ambient", "Relaxing sounds", 1L);
        Track mockTrack = Track.builder()
                .id(1L)
                .title("Sunset Horizon")
                .playCountCache(2500L)
                .genre(mockGenre)
                .build();

        when(trackRepository.findTopTracksByPlayCount(eq(TrackPublicationStatus.PUBLISHED), any(Pageable.class))).thenReturn(List.of(mockTrack));
        when(userRepository.findUsersCreatedSince(any())).thenReturn(Collections.emptyList());
        when(userRepository.findTop5ByDeletedAtIsNullOrderByCreatedAtDesc()).thenReturn(Collections.emptyList());

        SystemStatisticsResponse response = adminStatisticsService.getSystemStatistics("7d");

        assertNotNull(response);
        assertEquals("7d", response.period());
        assertNotNull(response.overview());
        assertEquals(100L, response.overview().totalUsers());
        assertEquals(85L, response.overview().activeUsers());
        assertEquals(50L, response.overview().publishedTracks());
        assertEquals(12000L, response.overview().totalPlays());
        assertEquals(3L, response.overview().pendingReviews());
        assertEquals(2L, response.overview().pendingReports());
        assertEquals(8L, response.overview().activeGenres());
        assertEquals(15L, response.overview().totalCreators());

        assertEquals(1, response.topTracks().size());
        assertEquals("Sunset Horizon", response.topTracks().get(0).title());
        assertEquals("Ambient", response.topTracks().get(0).genreName());
        assertEquals(2500L, response.topTracks().get(0).playCount());

        assertNotNull(response.systemHealth());
        assertEquals("Operational", response.systemHealth().restApiStatus());
    }

    @Test
    void getSystemStatistics_WithInvalidPeriod_ShouldDefaultTo7d() {
        when(userRepository.countByDeletedAtIsNull()).thenReturn(0L);
        when(trackRepository.countByPublicationStatus(TrackPublicationStatus.PUBLISHED)).thenReturn(0L);
        when(trackRepository.findTopTracksByPlayCount(eq(TrackPublicationStatus.PUBLISHED), any(Pageable.class))).thenReturn(Collections.emptyList());
        when(userRepository.findUsersCreatedSince(any())).thenReturn(Collections.emptyList());
        when(userRepository.findTop5ByDeletedAtIsNullOrderByCreatedAtDesc()).thenReturn(Collections.emptyList());

        SystemStatisticsResponse response = adminStatisticsService.getSystemStatistics("invalid_period");

        assertNotNull(response);
        assertEquals("7d", response.period());
    }

    @Test
    void getSystemStatistics_WhenNoData_ShouldHandleZeroAndNullGracefully() {
        when(userRepository.countByDeletedAtIsNull()).thenReturn(0L);
        when(trackRepository.sumPlayCountCache()).thenReturn(null);
        when(trackRepository.countDistinctUploaders()).thenReturn(null);
        when(trackRepository.findTopTracksByPlayCount(eq(TrackPublicationStatus.PUBLISHED), any(Pageable.class))).thenReturn(Collections.emptyList());
        when(userRepository.findUsersCreatedSince(any())).thenReturn(Collections.emptyList());
        when(userRepository.findTop5ByDeletedAtIsNullOrderByCreatedAtDesc()).thenReturn(Collections.emptyList());

        SystemStatisticsResponse response = adminStatisticsService.getSystemStatistics("30d");

        assertNotNull(response);
        assertEquals("30d", response.period());
        assertEquals(0L, response.overview().totalPlays());
        assertEquals(0L, response.overview().totalCreators());
        assertTrue(response.topTracks().isEmpty());
        assertTrue(response.recentAccounts().isEmpty());
    }
}
