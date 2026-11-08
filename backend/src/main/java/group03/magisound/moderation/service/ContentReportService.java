package group03.magisound.moderation.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ForbiddenOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.moderation.dto.request.CreateContentReportRequest;
import group03.magisound.moderation.dto.request.CreateTrackReportRequest;
import group03.magisound.moderation.dto.request.UpdateTrackReportRequest;
import group03.magisound.moderation.dto.response.ContentReportResponse;
import group03.magisound.moderation.dto.response.MyReportHistoryResponse;
import group03.magisound.moderation.dto.response.TrackReportResponse;
import group03.magisound.moderation.entity.ContentReport;
import group03.magisound.moderation.entity.ReportCategory;
import group03.magisound.moderation.repository.ContentReportRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Service xử lý các nghiệp vụ liên quan đến báo cáo nội dung (UC-16.1 & UC-16.2).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ContentReportService {

    private final ContentReportRepository contentReportRepository;
    private final AppUserRepository userRepository;
    private final TrackRepository trackRepository;

    /**
     * Tiếp nhận báo cáo vi phạm nội dung đối với bài hát đã phát hành từ người nghe (UC-16.1).
     */
    @Transactional
    public TrackReportResponse submitTrackReport(String userEmail, CreateTrackReportRequest request) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        Track track = trackRepository.findById(request.trackId())
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + request.trackId()));

        if (track.getPublicationStatus() != TrackPublicationStatus.PUBLISHED) {
            throw new BadRequestOperationException(
                    "TRACK_NOT_ELIGIBLE",
                    "This track is no longer available for reporting"
            );
        }

        if (!ReportCategory.isValid(request.category())) {
            throw new BadRequestOperationException(
                    "INVALID_REPORT_CATEGORY",
                    "Invalid report category. Must be one of COPYRIGHT, INAPPROPRIATE_CONTENT, INCORRECT_METADATA, OTHER."
            );
        }
        ReportCategory category = ReportCategory.fromString(request.category());

        String description = (request.description() != null && !request.description().isBlank())
                ? request.description().trim()
                : category.getDisplayName();

        boolean alreadyPending = contentReportRepository.hasPendingReportForTrack(
                track.getId(),
                user.getId(),
                "PENDING"
        );
        if (alreadyPending) {
            throw new BadRequestOperationException(
                    "REPORT_ALREADY_EXISTS",
                    "You have already submitted a pending report for this track. Our moderation team is reviewing it."
            );
        }

        ContentReport report = ContentReport.builder()
                .trackId(track.getId())
                .submittedByUserId(user.getId())
                .reporterId(user.getId())
                .targetType("TRACK")
                .targetId(track.getId())
                .category(category.name())
                .reason(category.name())
                .description(description)
                .status("PENDING")
                .build();

        ContentReport saved = contentReportRepository.save(report);
        log.info("Content report #{} submitted for trackId: {} by user: {} with category: {}",
                saved.getId(), track.getId(), user.getEmail(), category.name());

        return new TrackReportResponse(
                saved.getId(),
                track.getId(),
                track.getTitle(),
                track.getCoverUrl(),
                user.getId(),
                category.name(),
                category.getDisplayName(),
                saved.getDescription(),
                saved.getStatus(),
                saved.getCreatedAt()
        );
    }

    /**
     * Cập nhật lý do báo cáo đang ở trạng thái PENDING.
     */
    @Transactional
    public TrackReportResponse updateTrackReport(Long reportId, String userEmail, UpdateTrackReportRequest request) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        ContentReport report = contentReportRepository.findById(reportId)
                .orElseThrow(() -> new ResourceNotFoundException("REPORT_NOT_FOUND", "Content report not found with id: " + reportId));

        Long ownerId = report.getSubmittedByUserId() != null ? report.getSubmittedByUserId() : report.getReporterId();
        if (!user.getId().equals(ownerId)) {
            throw new ForbiddenOperationException("FORBIDDEN", "You are not authorized to update this report");
        }

        if (!"PENDING".equalsIgnoreCase(report.getStatus())) {
            throw new BadRequestOperationException(
                    "REPORT_NOT_PENDING",
                    "Only pending reports can be updated. Current status: " + report.getStatus()
            );
        }

        if (!ReportCategory.isValid(request.category())) {
            throw new BadRequestOperationException(
                    "INVALID_REPORT_CATEGORY",
                    "Invalid report category. Must be one of COPYRIGHT, INAPPROPRIATE_CONTENT, INCORRECT_METADATA, OTHER."
            );
        }
        ReportCategory category = ReportCategory.fromString(request.category());

        String description = (request.description() != null && !request.description().isBlank())
                ? request.description().trim()
                : category.getDisplayName();

        report.setCategory(category.name());
        report.setReason(category.name());
        report.setDescription(description);
        ContentReport updated = contentReportRepository.save(report);

        Long trackId = updated.getTrackId() != null ? updated.getTrackId() : updated.getTargetId();
        Track track = trackId != null ? trackRepository.findById(trackId).orElse(null) : null;
        String trackTitle = track != null ? track.getTitle() : "Track #" + trackId;
        String coverUrl = track != null ? track.getCoverUrl() : null;

        return new TrackReportResponse(
                updated.getId(),
                trackId,
                trackTitle,
                coverUrl,
                ownerId,
                category.name(),
                category.getDisplayName(),
                updated.getDescription(),
                updated.getStatus(),
                updated.getCreatedAt()
        );
    }

    /**
     * Rút lại (hủy) báo cáo vi phạm nội dung đang ở trạng thái PENDING.
     */
    @Transactional
    public void withdrawTrackReport(Long reportId, String userEmail) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        ContentReport report = contentReportRepository.findById(reportId)
                .orElseThrow(() -> new ResourceNotFoundException("REPORT_NOT_FOUND", "Content report not found with id: " + reportId));

        Long ownerId = report.getSubmittedByUserId() != null ? report.getSubmittedByUserId() : report.getReporterId();
        if (!user.getId().equals(ownerId)) {
            throw new ForbiddenOperationException("FORBIDDEN", "You are not authorized to withdraw this report");
        }

        if (!"PENDING".equalsIgnoreCase(report.getStatus())) {
            throw new BadRequestOperationException(
                    "REPORT_NOT_PENDING",
                    "Only pending reports can be withdrawn. Current status: " + report.getStatus()
            );
        }

        contentReportRepository.delete(report);
        log.info("Report #{} withdrawn and removed by user: {}", reportId, user.getEmail());
    }

    /**
     * Lấy danh sách lịch sử báo cáo của người dùng (UC-16.2).
     */
    @Transactional(readOnly = true)
    public List<MyReportHistoryResponse> getMyReports(String userEmail) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        List<ContentReport> reports = contentReportRepository.findMyReports(user.getId());
        if (reports.isEmpty()) {
            return Collections.emptyList();
        }

        Set<Long> trackIds = reports.stream()
                .map(r -> r.getTrackId() != null ? r.getTrackId() : r.getTargetId())
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Long, Track> trackMap = trackRepository.findAllById(trackIds).stream()
                .collect(Collectors.toMap(Track::getId, Function.identity()));

        return reports.stream().map(r -> {
            Long trackId = r.getTrackId() != null ? r.getTrackId() : r.getTargetId();
            Track track = trackId != null ? trackMap.get(trackId) : null;
            String trackTitle = track != null ? track.getTitle() : "Track #" + trackId;
            String coverUrl = track != null ? track.getCoverUrl() : null;

            String cat = r.getCategory() != null ? r.getCategory() : r.getReason();
            String catLabel = ReportCategory.isValid(cat)
                    ? ReportCategory.fromString(cat).getDisplayName()
                    : (cat != null ? cat : "Other");

            return new MyReportHistoryResponse(
                    r.getId(),
                    trackId,
                    trackTitle,
                    coverUrl,
                    cat,
                    catLabel,
                    r.getStatus(),
                    r.getResolutionNote() != null ? r.getResolutionNote() : r.getReviewerNote(),
                    r.getCreatedAt(),
                    r.getHandledAt() != null ? r.getHandledAt() : r.getResolvedAt()
            );
        }).toList();
    }

    /**
     * Kiểm tra nhanh xem người nghe đã có báo cáo đang chờ xử lý (PENDING) cho bài hát hay chưa.
     */
    @Transactional(readOnly = true)
    public boolean checkPendingReport(String userEmail, Long trackId) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        return contentReportRepository.hasPendingReportForTrack(trackId, user.getId(), "PENDING");
    }

    /**
     * Tiếp nhận báo cáo lỗi lời bài hát.
     */
    @Transactional
    public ContentReportResponse submitLyricReport(String userEmail, CreateContentReportRequest request) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        Track track = trackRepository.findById(request.trackId())
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + request.trackId()));

        String reason = request.reason().trim();
        String description = request.description() != null ? request.description().trim() : null;

        List<ContentReport> existing = contentReportRepository.findByReporterIdAndTargetTypeAndTargetId(
                user.getId(), "LYRICS", track.getId()
        );
        boolean hasPending = existing.stream().anyMatch(r -> "PENDING".equalsIgnoreCase(r.getStatus()));
        if (hasPending) {
            throw new BadRequestOperationException(
                    "REPORT_ALREADY_EXISTS",
                    "You have already submitted a pending report for this song's lyrics. Our moderation team is reviewing it."
            );
        }

        ContentReport report = ContentReport.builder()
                .trackId(track.getId())
                .submittedByUserId(user.getId())
                .category(reason)
                .reporterId(user.getId())
                .targetType("LYRICS")
                .targetId(track.getId())
                .reason(reason)
                .description(description)
                .status("PENDING")
                .build();

        ContentReport saved = contentReportRepository.save(report);
        log.info("Content report #{} created for LYRICS on trackId: {} by user: {}", saved.getId(), track.getId(), user.getEmail());

        return new ContentReportResponse(
                saved.getId(),
                saved.getReporterId(),
                saved.getTargetType(),
                saved.getTargetId(),
                saved.getReason(),
                saved.getDescription(),
                saved.getStatus(),
                saved.getCreatedAt()
        );
    }
}
