package group03.magisound.studio.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserStatus;
import group03.magisound.authentication.exception.AccountBannedException;
import group03.magisound.authentication.exception.AccountUnavailableException;
import group03.magisound.authentication.exception.AuthenticationException;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.GenreRepository;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ConflictOperationException;
import group03.magisound.exception.ForbiddenOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.library.repository.ListeningHistoryRepository;
import group03.magisound.library.repository.PlaylistTrackRepository;
import group03.magisound.media.dto.response.StoredAudioResponse;
import group03.magisound.media.dto.response.StoredMediaResponse;
import group03.magisound.media.service.InternalMediaService;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.entity.TrackSubmission;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import group03.magisound.notification.entity.NotificationType;
import group03.magisound.notification.service.NotificationService;
import group03.magisound.studio.dto.request.CreateTrackRequest;
import group03.magisound.studio.dto.request.UpdateTrackRequest;
import group03.magisound.studio.dto.response.GenreOptionResponse;
import group03.magisound.studio.dto.response.RejectionDetailsResponse;
import group03.magisound.studio.dto.response.StudioStatsResponse;
import group03.magisound.studio.dto.response.StudioTrackResponse;
import group03.magisound.studio.mapper.StudioTrackMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.text.Normalizer;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Locale;
import java.util.regex.Pattern;

@Slf4j
@Service
@RequiredArgsConstructor
public class StudioTrackService {

    private final TrackRepository trackRepository;
    private final GenreRepository genreRepository;
    private final TrackSubmissionRepository trackSubmissionRepository;
    private final PlaylistTrackRepository playlistTrackRepository;
    private final ListeningHistoryRepository listeningHistoryRepository;
    private final AppUserRepository appUserRepository;
    private final InternalMediaService cloudMediaService;
    private final StudioTrackMapper studioTrackMapper;
    private final NotificationService notificationService;

    private static final Pattern NONLATIN = Pattern.compile("[^\\w-]");
    private static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    @Transactional(readOnly = true)
    public List<StudioTrackResponse> getMyTracks(String currentUserEmail, String statusFilter) {
        AppUser user = getAuthenticatedUser(currentUserEmail);

        List<Track> tracks;
        if (statusFilter == null || statusFilter.isBlank() || "ALL".equalsIgnoreCase(statusFilter)) {
            tracks = trackRepository.findByUploaderUserIdOrderByCreatedAtDesc(user.getId());
        } else {
            try {
                String normalizedFilter = statusFilter.trim().toUpperCase(Locale.ROOT);
                if ("APPROVED".equals(normalizedFilter)) {
                    normalizedFilter = "PUBLISHED";
                }
                TrackPublicationStatus status = TrackPublicationStatus.valueOf(normalizedFilter);
                tracks = trackRepository.findByUploaderUserIdAndPublicationStatusOrderByCreatedAtDesc(user.getId(), status);
            } catch (IllegalArgumentException ex) {
                tracks = trackRepository.findByUploaderUserIdOrderByCreatedAtDesc(user.getId());
            }
        }

        return tracks.stream().map(track -> {
            Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
            TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);
            return studioTrackMapper.toStudioTrackResponse(track, genre, submission);
        }).toList();
    }

    @Transactional(readOnly = true)
    public StudioTrackResponse getTrackById(Long id, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
        TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, submission);
    }

    @Transactional
    public StudioTrackResponse createDraft(CreateTrackRequest request, MultipartFile audio, MultipartFile cover, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);

        if (audio == null || audio.isEmpty()) {
            throw new BadRequestOperationException("Audio file is required to upload a track.");
        }

        Genre genre = genreRepository.findById(request.genreId())
                .orElseThrow(() -> new BadRequestOperationException("Selected genre is invalid."));
        if (!Boolean.TRUE.equals(genre.getIsActive())) {
            throw new BadRequestOperationException("Selected genre is currently inactive.");
        }


        StoredAudioResponse audioResponse = cloudMediaService.uploadTrackAudio(audio, user.getId());

        StoredMediaResponse coverResponse = null;
        if (cover != null && !cover.isEmpty()) {
            coverResponse = cloudMediaService.uploadTrackCover(cover, user.getId());
        }

        String slug = generateUniqueSlug(request.title());
        int finalDurationMs = request.durationMs() != null && request.durationMs() > 0
                ? request.durationMs()
                : (audioResponse.durationMs() != null ? audioResponse.durationMs() : 0);

        Track track = Track.builder()
                .uploaderUserId(user.getId())
                .genre(genre)
                .title(request.title().trim())
                .slug(slug)
                .description(request.description() != null ? request.description().trim() : null)
                .trackNumber(request.trackNumber())
                .publicationStatus(TrackPublicationStatus.DRAFT)
                .audioPublicId(audioResponse.publicId())
                .audioUrl(audioResponse.secureUrl())
                .audioFormat(audioResponse.format() != null ? audioResponse.format() : "mp3")
                .durationMs(finalDurationMs)
                .coverPublicId(coverResponse != null ? coverResponse.publicId() : null)
                .coverUrl(coverResponse != null ? coverResponse.secureUrl() : null)
                .playCountCache(0L)
                .lyrics(request.lyrics() != null && !request.lyrics().isBlank() ? request.lyrics().trim() : null)
                .build();

        Track savedTrack = trackRepository.save(track);
        return studioTrackMapper.toStudioTrackResponse(savedTrack, genre, null);
    }

    @Transactional
    public StudioTrackResponse updateTrack(Long id, UpdateTrackRequest request, MultipartFile audio, MultipartFile cover, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        if (track.getPublicationStatus() == TrackPublicationStatus.PENDING) {
            throw new ForbiddenOperationException("Tracks currently pending review cannot be modified. Please withdraw the submission first.");
        }
        if (track.getPublicationStatus() == TrackPublicationStatus.TAKEN_DOWN) {
            throw new ForbiddenOperationException("Taken down tracks cannot be modified.");
        }

        Genre genre = genreRepository.findById(request.genreId())
                .orElseThrow(() -> new BadRequestOperationException("Selected genre is invalid."));
        if (!Boolean.TRUE.equals(genre.getIsActive())) {
            throw new BadRequestOperationException("Selected genre is currently inactive.");
        }


        if (audio != null && !audio.isEmpty()) {
            StoredAudioResponse audioResponse = cloudMediaService.uploadTrackAudio(audio, user.getId());
            cloudMediaService.deleteTrackAudioQuietly(track.getAudioPublicId());

            track.setAudioPublicId(audioResponse.publicId());
            track.setAudioUrl(audioResponse.secureUrl());
            track.setAudioFormat(audioResponse.format() != null ? audioResponse.format() : "mp3");
            track.setDurationMs(request.durationMs() != null && request.durationMs() > 0
                    ? request.durationMs()
                    : (audioResponse.durationMs() != null ? audioResponse.durationMs() : track.getDurationMs()));
        } else if (request.durationMs() != null && request.durationMs() > 0) {
            track.setDurationMs(request.durationMs());
        }

        if (cover != null && !cover.isEmpty()) {
            StoredMediaResponse coverResponse = cloudMediaService.uploadTrackCover(cover, user.getId());
            cloudMediaService.deleteImageQuietly(track.getCoverPublicId());

            track.setCoverPublicId(coverResponse.publicId());
            track.setCoverUrl(coverResponse.secureUrl());
        }

        if (!track.getTitle().equalsIgnoreCase(request.title().trim())) {
            track.setTitle(request.title().trim());
            track.setSlug(generateUniqueSlug(request.title()));
        }

        track.setGenre(genre);
        track.setTrackNumber(request.trackNumber());
        track.setDescription(request.description() != null ? request.description().trim() : null);
        if (request.lyrics() != null) {
            track.setLyrics(request.lyrics().isBlank() ? null : request.lyrics().trim());
        }

        Track updatedTrack = trackRepository.save(track);


        TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(updatedTrack, genre, submission);
    }

    @Transactional
    public void deleteTrack(Long id, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));


        playlistTrackRepository.deleteByTrack_Id(track.getId());
        listeningHistoryRepository.deleteByTrackId(track.getId());
        trackSubmissionRepository.deleteByTrackId(track.getId());
        cloudMediaService.deleteTrackAudioQuietly(track.getAudioPublicId());
        cloudMediaService.deleteImageQuietly(track.getCoverPublicId());

        trackRepository.delete(track);

    }

    @Transactional
    public StudioTrackResponse submitForReview(Long id, String submitterNote, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        if (track.getPublicationStatus() != TrackPublicationStatus.DRAFT && track.getPublicationStatus() != TrackPublicationStatus.REJECTED) {
            throw new ConflictOperationException("Only DRAFT or REJECTED tracks can be submitted for review.");
        }

        track.setPublicationStatus(TrackPublicationStatus.PENDING);
        trackRepository.save(track);

        TrackSubmission submission = TrackSubmission.builder()
                .trackId(track.getId())
                .submittedByUserId(user.getId())
                .status(SubmissionStatus.PENDING)
                .submitterNote(submitterNote)
                .build();
        TrackSubmission savedSubmission = trackSubmissionRepository.save(submission);

        try {
            List<AppUser> staffUsers = appUserRepository.findByRole_CodeIn(List.of("STAFF", "ADMIN"));
            for (AppUser staff : staffUsers) {
                notificationService.createNotification(
                        staff.getId(),
                        user.getId(),
                        NotificationType.TRACK_SUBMISSION,
                        "New submission for review",
                        "Track \"" + track.getTitle() + "\" has been submitted for moderation.",
                        "SUBMISSION",
                        String.valueOf(savedSubmission.getId())
                );
            }
        } catch (Exception e) {
            log.warn("Failed to create submission notification for staff: {}", e.getMessage());
        }

        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, savedSubmission);
    }

    @Transactional
    public StudioTrackResponse withdrawSubmission(Long id, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        if (track.getPublicationStatus() != TrackPublicationStatus.PENDING) {
            throw new ConflictOperationException("Only PENDING tracks can be withdrawn from review.");
        }

        track.setPublicationStatus(TrackPublicationStatus.DRAFT);
        trackRepository.save(track);

        trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId())
                .ifPresent(sub -> {
                    if (sub.getStatus() == SubmissionStatus.PENDING) {
                        trackSubmissionRepository.delete(sub);
                    }
                });

        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, null);
    }

    /**
     * Lấy thông tin chi tiết lý do từ chối kiểm duyệt của bài hát.
     *
     * Đáp ứng đặc tả RDS:
     * - Use Case: UC-20 (View Rejection Reason)
     * - Actor: Listener (Chủ sở hữu bản nhạc đã tải lên)
     * - Precondition PRE-1: Người dùng đã đăng nhập (currentUserEmail).
     * - Precondition PRE-2: Bài hát thuộc quyền sở hữu của người dùng (Uploader).
     * - Exception EX02: Nếu bài hát không tồn tại hoặc không thuộc quyền sở hữu, từ chối truy cập.
     * - Normal Flow: Trả về lý do từ chối (BR-20), ghi chú của kiểm duyệt viên và thời gian duyệt.
     * - Alternative Flow AF01: Trả về toàn bộ lịch sử các đợt nộp duyệt và phản hồi trước đó.
     * - Business Rule BR-24: Dữ liệu này chỉ đọc (read-only), làm cơ sở để nghệ sĩ chỉnh sửa và nộp lại.
     *
     * @param id               ID của bài hát cần xem lý do từ chối
     * @param currentUserEmail Email của người dùng đang đăng nhập
     * @return RejectionDetailsResponse chi tiết lý do từ chối và lịch sử
     */
    @Transactional(readOnly = true)
    public RejectionDetailsResponse getRejectionDetails(Long id, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        List<TrackSubmission> submissions = trackSubmissionRepository.findByTrackIdOrderBySubmittedAtDesc(track.getId());
        return studioTrackMapper.toRejectionDetails(track, submissions);
    }

    @Transactional(readOnly = true)
    public StudioStatsResponse getStats(String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        long total = trackRepository.countByUploaderUserId(user.getId());
        long draft = trackRepository.countByUploaderUserIdAndPublicationStatus(user.getId(), TrackPublicationStatus.DRAFT);
        long pending = trackRepository.countByUploaderUserIdAndPublicationStatus(user.getId(), TrackPublicationStatus.PENDING);
        long approved = trackRepository.countByUploaderUserIdAndPublicationStatus(user.getId(), TrackPublicationStatus.PUBLISHED);
        long rejected = trackRepository.countByUploaderUserIdAndPublicationStatus(user.getId(), TrackPublicationStatus.REJECTED);

        return new StudioStatsResponse(total, draft, pending, approved, rejected);
    }

    @Transactional(readOnly = true)
    public List<GenreOptionResponse> getActiveGenres() {
        return genreRepository.findByIsActiveTrueOrderByNameAsc()
                .stream()
                .map(studioTrackMapper::toGenreOption)
                .toList();
    }


    private AppUser getAuthenticatedUser(String email) {
        if (email == null || email.isBlank()) {
            throw new AuthenticationException("UNAUTHORIZED", "Authentication required.");
        }
        AppUser user = appUserRepository.findByEmailIgnoreCase(email.trim().toLowerCase(Locale.ROOT))
                .filter(u -> u.getDeletedAt() == null)
                .orElseThrow(() -> new AuthenticationException("USER_NOT_FOUND", "Account not found."));

        if (user.getStatus() == UserStatus.BANNED) {
            throw new AccountBannedException();
        }
        if (user.getStatus() == UserStatus.PENDING) {
            throw new AccountUnavailableException("ACCOUNT_PENDING", "Account email has not been verified yet.");
        }
        return user;
    }

    private String generateUniqueSlug(String input) {
        String baseSlug = toSlug(input);
        if (baseSlug.isBlank()) baseSlug = "track";
        String slug = baseSlug + "-" + System.currentTimeMillis();
        return slug.length() > 220 ? slug.substring(0, 220) : slug;
    }

    private String toSlug(String input) {
        String nowhitespace = WHITESPACE.matcher(input).replaceAll("-");
        String normalized = Normalizer.normalize(nowhitespace, Normalizer.Form.NFD);
        String slug = NONLATIN.matcher(normalized).replaceAll("");
        return slug.toLowerCase(Locale.ENGLISH);
    }
}

