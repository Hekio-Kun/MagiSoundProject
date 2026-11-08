package group03.magisound.moderation.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.Role;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ForbiddenOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.moderation.dto.request.CreateTrackReportRequest;
import group03.magisound.moderation.dto.request.UpdateTrackReportRequest;
import group03.magisound.moderation.dto.response.TrackReportResponse;
import group03.magisound.moderation.entity.ContentReport;
import group03.magisound.moderation.repository.ContentReportRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.Instant;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ContentReportServiceTest {

    @Mock
    private ContentReportRepository contentReportRepository;

    @Mock
    private AppUserRepository userRepository;

    @Mock
    private TrackRepository trackRepository;

    @InjectMocks
    private ContentReportService contentReportService;

    private AppUser mockUser;
    private Track mockTrack;

    @BeforeEach
    void setUp() {
        mockUser = new AppUser(new Role("LISTENER", "Listener", "Normal user"), "listener@magisound.com", "hashed_password");
        ReflectionTestUtils.setField(mockUser, "id", 10L);

        Genre genre = new Genre("Pop", "pop", "Pop music", 1L);
        ReflectionTestUtils.setField(genre, "id", 10L);

        mockTrack = new Track(
                100L,
                genre,
                "Test Song",
                "test-song",
                "Description",
                "pub_1",
                "https://example.com/audio.mp3",
                "mp3",
                180000,
                "cover_1",
                "https://example.com/cover.jpg",
                TrackPublicationStatus.PUBLISHED
        );
        ReflectionTestUtils.setField(mockTrack, "id", 100L);
    }

    @Test
    @DisplayName("submitTrackReport - Successfully creates track report when valid (UC-16.1)")
    void submitTrackReport_Success() {
        when(userRepository.findByEmailIgnoreCase("listener@magisound.com")).thenReturn(Optional.of(mockUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(mockTrack));
        when(contentReportRepository.hasPendingReportForTrack(100L, 10L, "PENDING")).thenReturn(false);

        when(contentReportRepository.save(any(ContentReport.class))).thenAnswer(invocation -> {
            ContentReport report = invocation.getArgument(0);
            report.setId(1L);
            report.setCreatedAt(Instant.now());
            return report;
        });

        CreateTrackReportRequest request = new CreateTrackReportRequest(
                100L,
                "COPYRIGHT"
        );

        TrackReportResponse response = contentReportService.submitTrackReport("listener@magisound.com", request);

        assertNotNull(response);
        assertEquals(1L, response.id());
        assertEquals(100L, response.trackId());
        assertEquals("Test Song", response.trackTitle());
        assertEquals("COPYRIGHT", response.category());
        assertEquals("Copyright Infringement", response.categoryLabel());
        assertEquals("PENDING", response.status());

        verify(contentReportRepository, times(1)).save(any(ContentReport.class));
    }

    @Test
    @DisplayName("submitTrackReport - Throws BadRequestOperationException when duplicate pending report exists (UC-16.1)")
    void submitTrackReport_DuplicatePendingReport() {
        when(userRepository.findByEmailIgnoreCase("listener@magisound.com")).thenReturn(Optional.of(mockUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(mockTrack));
        when(contentReportRepository.hasPendingReportForTrack(100L, 10L, "PENDING")).thenReturn(true);

        CreateTrackReportRequest request = new CreateTrackReportRequest(100L, "COPYRIGHT");

        assertThrows(BadRequestOperationException.class, () ->
                contentReportService.submitTrackReport("listener@magisound.com", request)
        );
        verify(contentReportRepository, never()).save(any(ContentReport.class));
    }

    @Test
    @DisplayName("withdrawTrackReport - Successfully withdraws and deletes pending report")
    void withdrawTrackReport_Success() {
        when(userRepository.findByEmailIgnoreCase("listener@magisound.com")).thenReturn(Optional.of(mockUser));

        ContentReport existing = ContentReport.builder()
                .id(1L)
                .trackId(100L)
                .submittedByUserId(10L)
                .category("COPYRIGHT")
                .status("PENDING")
                .build();
        when(contentReportRepository.findById(1L)).thenReturn(Optional.of(existing));

        contentReportService.withdrawTrackReport(1L, "listener@magisound.com");

        verify(contentReportRepository, times(1)).delete(existing);
    }
}
