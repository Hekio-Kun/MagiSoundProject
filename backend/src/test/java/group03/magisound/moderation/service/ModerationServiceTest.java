package group03.magisound.moderation.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.Role;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.moderation.dto.request.ApproveTrackRequest;
import group03.magisound.moderation.dto.request.RejectTrackRequest;
import group03.magisound.moderation.dto.request.TakeDownTrackRequest;
import group03.magisound.moderation.dto.response.SubmissionDetailResponse;
import group03.magisound.moderation.dto.response.TrackDetailResponse;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.entity.TrackSubmission;
import group03.magisound.moderation.exception.InvalidSubmissionStateException;
import group03.magisound.moderation.exception.SubmissionNotFoundException;
import group03.magisound.moderation.mapper.TrackSubmissionMapper;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import group03.magisound.moderation.repository.ContentReportRepository;
import group03.magisound.notification.service.NotificationService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.Instant;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ModerationServiceTest {

    @Mock private TrackSubmissionRepository submissionRepository;
    @Mock private TrackRepository trackRepository;
    @Mock private ModerationMailService mailService;
    @Mock private TrackSubmissionMapper mapper;
    @Mock private AppUserRepository userRepository;
    @Mock private UserProfileRepository profileRepository;
    @Mock private NotificationService notificationService;
    @Mock private ContentReportRepository contentReportRepository;

    private ModerationService moderationService;
    private AppUser staffUser;
    private Track testTrack;

    @BeforeEach
    void setUp() {
        moderationService = new ModerationService(
                submissionRepository,
                trackRepository,
                mailService,
                mapper,
                userRepository,
                profileRepository,
                notificationService,
                contentReportRepository
        );

        staffUser = new AppUser(
                new Role("STAFF", "Staff", "Staff role"),
                "staff@soundwave.com",
                "hashedpwd"
        );
        ReflectionTestUtils.setField(staffUser, "id", 99L);

        Genre genre = Genre.builder().name("Rock").slug("rock").build();
        ReflectionTestUtils.setField(genre, "id", 1L);

        testTrack = Track.builder()
                .uploaderUserId(10L)
                .title("Echoes of Summer")
                .slug("echoes-of-summer")
                .genre(genre)
                .publicationStatus(TrackPublicationStatus.PENDING)
                .lyrics("[00:01.00]Hello world\n[00:05.00]Echoes of summer")
                .build();
        ReflectionTestUtils.setField(testTrack, "id", 100L);
    }

    @Test
    void approveSubmission_Success() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.PENDING)
                .submittedAt(Instant.now())
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(userRepository.findByEmailIgnoreCase("staff@soundwave.com")).thenReturn(Optional.of(staffUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));
        when(trackRepository.save(any(Track.class))).thenAnswer(i -> i.getArgument(0));
        when(submissionRepository.save(any(TrackSubmission.class))).thenAnswer(i -> i.getArgument(0));

        ApproveTrackRequest request = new ApproveTrackRequest("Great track!");
        moderationService.approveSubmission(1L, request, "staff@soundwave.com");

        assertEquals(SubmissionStatus.APPROVED, submission.getStatus());
        assertEquals(99L, submission.getReviewerUserId());
        assertEquals("Great track!", submission.getReviewerNote());
        assertEquals(TrackPublicationStatus.PUBLISHED, testTrack.getPublicationStatus());
        assertNotNull(testTrack.getApprovedAt());

        verify(trackRepository).save(testTrack);
        verify(submissionRepository).save(submission);
    }

    @Test
    void approveSubmission_WhenNotPending_ThrowsInvalidStateException() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.APPROVED)
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));

        ApproveTrackRequest request = new ApproveTrackRequest("Note");
        assertThrows(InvalidSubmissionStateException.class,
                () -> moderationService.approveSubmission(1L, request, "staff@soundwave.com"));
    }

    @Test
    void rejectSubmission_Success() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.PENDING)
                .submittedAt(Instant.now())
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(userRepository.findByEmailIgnoreCase("staff@soundwave.com")).thenReturn(Optional.of(staffUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));
        when(trackRepository.save(any(Track.class))).thenAnswer(i -> i.getArgument(0));
        when(submissionRepository.save(any(TrackSubmission.class))).thenAnswer(i -> i.getArgument(0));

        RejectTrackRequest request = new RejectTrackRequest("Audio clipping detected", "Please re-export in WAV");
        moderationService.rejectSubmission(1L, request, "staff@soundwave.com");

        assertEquals(SubmissionStatus.REJECTED, submission.getStatus());
        assertEquals("Audio clipping detected", submission.getRejectionReason());
        assertEquals(TrackPublicationStatus.REJECTED, testTrack.getPublicationStatus());
        assertEquals("Audio clipping detected", testTrack.getLatestRejectionReason());

        verify(trackRepository).save(testTrack);
        verify(submissionRepository).save(submission);
    }

    @Test
    void takeDownSubmission_Success() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.APPROVED)
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(userRepository.findByEmailIgnoreCase("staff@soundwave.com")).thenReturn(Optional.of(staffUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));
        when(trackRepository.save(any(Track.class))).thenAnswer(i -> i.getArgument(0));
        when(submissionRepository.save(any(TrackSubmission.class))).thenAnswer(i -> i.getArgument(0));

        TakeDownTrackRequest request = new TakeDownTrackRequest("Copyright infringement claim confirmed", "Removed by DMCA");
        moderationService.takeDownSubmission(1L, request, "staff@soundwave.com");

        assertEquals(SubmissionStatus.REJECTED, submission.getStatus());
        assertEquals("Copyright infringement claim confirmed", submission.getRejectionReason());
        assertEquals(TrackPublicationStatus.TAKEN_DOWN, testTrack.getPublicationStatus());
        assertEquals("Copyright infringement claim confirmed", testTrack.getLatestRejectionReason());

        verify(trackRepository).save(testTrack);
    }

    @Test
    void getSubmissionDetail_NotFound_ThrowsException() {
        when(submissionRepository.findById(999L)).thenReturn(Optional.empty());

        assertThrows(SubmissionNotFoundException.class,
                () -> moderationService.getSubmissionDetail(999L));
    }

    @Test
    void getSubmissionDetail_PassesLyricsFromTrackToMapper() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.PENDING)
                .submittedAt(Instant.now())
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));

        moderationService.getSubmissionDetail(1L);

        verify(mapper).toDetailResponse(
                eq(submission),
                eq(testTrack),
                any(),
                any(),
                any(),
                any(),
                eq("[00:01.00]Hello world\n[00:05.00]Echoes of summer")
        );
    }
}
