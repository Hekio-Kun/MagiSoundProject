package group03.magisound.moderation.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.lyrics.entity.OfficialLyric;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import group03.magisound.moderation.dto.request.ResolveContentReportRequest;
import group03.magisound.moderation.dto.request.TakeDownTrackRequest;
import group03.magisound.moderation.dto.response.StaffContentReportResponse;
import group03.magisound.moderation.entity.ContentReport;
import group03.magisound.moderation.entity.ReportCategory;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.entity.TrackSubmission;
import group03.magisound.moderation.repository.ContentReportRepository;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import group03.magisound.notification.entity.NotificationType;
import group03.magisound.notification.service.NotificationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class StaffContentReportService {

    private final ContentReportRepository contentReportRepository;
    private final TrackRepository trackRepository;
    private final AppUserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final TrackSubmissionRepository submissionRepository;
    private final NotificationService notificationService;
    private final OfficialLyricRepository officialLyricRepository;

    @Transactional(readOnly = true)
    public List<StaffContentReportResponse> getReportsQueue() {
        List<ContentReport> allReports = contentReportRepository.findAllByOrderByCreatedAtDesc();

        Map<String, List<ContentReport>> groupedMap = new LinkedHashMap<>();
        for (ContentReport report : allReports) {
            String reasonLabel = resolveReasonLabel(report);
            String targetKey = (report.getTargetId() != null ? report.getTargetId().toString() : "0") + "::"
                    + reasonLabel.trim().toLowerCase(Locale.ROOT);
            groupedMap.computeIfAbsent(targetKey, k -> new ArrayList<>()).add(report);
        }

        List<StaffContentReportResponse> responses = new ArrayList<>();
        for (List<ContentReport> group : groupedMap.values()) {
            if (!group.isEmpty()) {
                responses.add(mapGroupToResponse(group));
            }
        }
        return responses;
    }

    @Transactional(readOnly = true)
    public StaffContentReportResponse getReportById(Long id) {
        ContentReport target = contentReportRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("REPORT_NOT_FOUND", "Content report not found with id: " + id));

        String targetReasonLabel = resolveReasonLabel(target);
        List<ContentReport> allSameTrack = contentReportRepository.findByTargetIdAndStatus(target.getTargetId(), "PENDING");
        List<ContentReport> group = allSameTrack.stream()
                .filter(r -> resolveReasonLabel(r).equalsIgnoreCase(targetReasonLabel))
                .sorted(Comparator.comparing(ContentReport::getCreatedAt).reversed())
                .toList();

        if (group.isEmpty()) {
            group = List.of(target);
        }

        return mapGroupToResponse(group);
    }

    @Transactional
    public StaffContentReportResponse resolveReport(Long reportId, ResolveContentReportRequest request, String staffEmail) {
        ContentReport target = contentReportRepository.findById(reportId)
                .orElseThrow(() -> new ResourceNotFoundException("REPORT_NOT_FOUND", "Content report not found with id: " + reportId));

        AppUser reviewer = userRepository.findByEmailIgnoreCase(staffEmail)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff user not found with email: " + staffEmail));

        String normalizedDecision = request.decision().trim().toUpperCase(Locale.ROOT);
        String finalStatus;
        if ("RESOLVED".equals(normalizedDecision) || "APPROVED".equals(normalizedDecision)) {
            finalStatus = "RESOLVED";
        } else if ("DISMISSED".equals(normalizedDecision) || "REJECTED".equals(normalizedDecision)) {
            finalStatus = "DISMISSED";
        } else {
            throw new BadRequestOperationException("INVALID_DECISION", "Resolution decision must be either RESOLVED or DISMISSED.");
        }

        Instant now = Instant.now();
        String targetReasonLabel = resolveReasonLabel(target);
        List<ContentReport> sameGroup = contentReportRepository.findByTargetIdAndStatus(target.getTargetId(), "PENDING")
                .stream()
                .filter(r -> resolveReasonLabel(r).equalsIgnoreCase(targetReasonLabel))
                .toList();

        List<ContentReport> reportsToUpdate = sameGroup.isEmpty() ? List.of(target) : sameGroup;

        for (ContentReport r : reportsToUpdate) {
            r.setStatus(finalStatus);
            r.setResolutionNote(request.staffNote());
            r.setReviewerNote(request.staffNote());
            r.setHandledByUserId(reviewer.getId());
            r.setReviewerId(reviewer.getId());
            r.setHandledAt(now);
            r.setResolvedAt(now);
            contentReportRepository.save(r);

            Long reporterId = r.getSubmittedByUserId() != null ? r.getSubmittedByUserId() : r.getReporterId();
            if (reporterId != null) {
                try {
                    String title = "Resolution Update: Report #" + r.getId();
                    String msg = "Your report regarding " + targetReasonLabel + " has been marked as " + finalStatus
                            + ". Note: " + request.staffNote();
                    notificationService.createNotification(
                            reporterId,
                            reviewer.getId(),
                            NotificationType.CONTENT_REPORT,
                            title,
                            msg,
                            "CONTENT_REPORT",
                            String.valueOf(r.getId())
                    );
                } catch (Exception ex) {
                    log.warn("Failed to notify reporter ID {}: {}", reporterId, ex.getMessage());
                }
            }
        }

        log.info("Resolved {} report(s) on target {} with decision {} by staff {}",
                reportsToUpdate.size(), target.getTargetId(), finalStatus, staffEmail);

        return mapGroupToResponse(reportsToUpdate);
    }

    @Transactional
    public void takeDownPublishedTrack(Long trackId, TakeDownTrackRequest request, String staffEmail) {
        Track track = trackRepository.findById(trackId)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + trackId));

        AppUser reviewer = userRepository.findByEmailIgnoreCase(staffEmail)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff user not found: " + staffEmail));

        track.setPublicationStatus(TrackPublicationStatus.REJECTED);
        trackRepository.save(track);

        TrackSubmission latestSubmission = submissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(trackId).orElse(null);
        Instant now = Instant.now();
        if (latestSubmission != null) {
            latestSubmission.setStatus(SubmissionStatus.REJECTED);
            latestSubmission.setRejectionReason(request.takedownReason());
            latestSubmission.setReviewerNote(request.reviewerNote());
            latestSubmission.setReviewerUserId(reviewer.getId());
            latestSubmission.setReviewedAt(now);
            submissionRepository.save(latestSubmission);
        }

        List<ContentReport> pendingReports = contentReportRepository.findByTrackIdAndStatusIgnoreCase(trackId, "PENDING");
        for (ContentReport r : pendingReports) {
            r.setStatus("RESOLVED");
            r.setResolutionNote("Track taken down: " + request.takedownReason());
            r.setReviewerNote(request.reviewerNote());
            r.setHandledByUserId(reviewer.getId());
            r.setReviewerId(reviewer.getId());
            r.setHandledAt(now);
            r.setResolvedAt(now);
            contentReportRepository.save(r);
        }

        if (track.getUploaderUserId() != null) {
            try {
                notificationService.createNotification(
                        track.getUploaderUserId(),
                        reviewer.getId(),
                        NotificationType.TRACK_REJECTED,
                        "Track Removed: " + track.getTitle(),
                        "Your track '" + track.getTitle() + "' was taken down due to: " + request.takedownReason(),
                        "TRACK",
                        String.valueOf(track.getId())
                );
            } catch (Exception ex) {
                log.warn("Failed to notify creator for takedown of track {}: {}", trackId, ex.getMessage());
            }
        }

        log.warn("Track ID {} ('{}') TAKEN DOWN by staff {}. Reason: {}",
                trackId, track.getTitle(), staffEmail, request.takedownReason());
    }

    private StaffContentReportResponse mapGroupToResponse(List<ContentReport> group) {
        ContentReport primary = group.stream()
                .filter(r -> "PENDING".equalsIgnoreCase(r.getStatus()))
                .findFirst()
                .orElse(group.get(0));

        boolean hasPending = group.stream().anyMatch(r -> "PENDING".equalsIgnoreCase(r.getStatus()));
        String groupStatus = hasPending ? "PENDING" : primary.getStatus();

        List<Long> reportIds = group.stream().map(ContentReport::getId).toList();
        int reporterCount = group.size();

        List<StaffContentReportResponse.ReporterSummary> reporters = new ArrayList<>();
        for (ContentReport r : group) {
            String name = "Unknown Reporter";
            String email = null;
            Long reporterId = r.getSubmittedByUserId() != null ? r.getSubmittedByUserId() : r.getReporterId();
            if (reporterId != null) {
                Optional<AppUser> uOpt = userRepository.findById(reporterId);
                if (uOpt.isPresent()) {
                    email = uOpt.get().getEmail();
                    Optional<UserProfile> pOpt = userProfileRepository.findByUserId(reporterId);
                    name = pOpt.flatMap(up -> Optional.ofNullable(up.getDisplayName()))
                            .filter(d -> !d.isBlank())
                            .orElse(email);
                }
            }
            reporters.add(new StaffContentReportResponse.ReporterSummary(reporterId, name, email, r.getCreatedAt()));
        }

        StaffContentReportResponse.ReporterSummary primaryReporter = reporters.get(0);

        Long trackId = primary.getTrackId() != null ? primary.getTrackId() : primary.getTargetId();
        String trackTitle = "Unknown Track";
        String artistName = "Unknown Artist";
        String coverUrl = null;
        String audioUrl = null;
        String trackPublicationStatus = null;
        String lyrics = null;

        if (trackId != null) {
            Optional<Track> trackOpt = trackRepository.findById(trackId);
            if (trackOpt.isPresent()) {
                Track track = trackOpt.get();
                trackTitle = track.getTitle();
                coverUrl = track.getCoverUrl();
                audioUrl = track.getAudioUrl();
                trackPublicationStatus = track.getPublicationStatus() != null ? track.getPublicationStatus().name() : null;

                if (track.getUploaderUserId() != null) {
                    Optional<UserProfile> artistProfileOpt = userProfileRepository.findByUserId(track.getUploaderUserId());
                    if (artistProfileOpt.isPresent() && artistProfileOpt.get().getDisplayName() != null) {
                        artistName = artistProfileOpt.get().getDisplayName();
                    }
                }
            }

            lyrics = officialLyricRepository.findByTrackId(trackId)
                    .map(OfficialLyric::getLyricContent)
                    .orElse(null);
            if (lyrics == null && trackOpt.isPresent()) {
                lyrics = trackOpt.get().getLyrics();
            }
        }

        String reviewerName = null;
        Long reviewerId = primary.getHandledByUserId() != null ? primary.getHandledByUserId() : primary.getReviewerId();
        if (reviewerId != null) {
            Optional<AppUser> reviewerOpt = userRepository.findById(reviewerId);
            if (reviewerOpt.isPresent()) {
                Optional<UserProfile> pOpt = userProfileRepository.findByUserId(reviewerId);
                reviewerName = pOpt.flatMap(up -> Optional.ofNullable(up.getDisplayName()))
                        .filter(d -> !d.isBlank())
                        .orElse(reviewerOpt.get().getEmail());
            }
        }

        String displayReason = resolveReasonLabel(primary);

        return new StaffContentReportResponse(
                primary.getId(),
                reportIds,
                reporterCount,
                primaryReporter.reporterId(),
                primaryReporter.reporterName(),
                primaryReporter.reporterEmail(),
                reporters,
                primary.getTargetType(),
                primary.getTargetId(),
                trackId,
                trackTitle,
                artistName,
                coverUrl,
                audioUrl,
                trackPublicationStatus,
                lyrics,
                displayReason,
                groupStatus,
                reviewerId,
                reviewerName,
                primary.getResolutionNote() != null ? primary.getResolutionNote() : primary.getReviewerNote(),
                primary.getCreatedAt(),
                primary.getResolvedAt() != null ? primary.getResolvedAt() : primary.getHandledAt()
        );
    }

    private String resolveReasonLabel(ContentReport report) {
        if (report == null) return "Violation Report";
        String r = report.getReason();
        if (r == null || r.isBlank()) {
            r = report.getCategory();
        }
        if (ReportCategory.isValid(r)) {
            return ReportCategory.fromString(r).getDisplayName();
        }
        return (r != null && !r.isBlank()) ? r : "Violation Report";
    }
}
