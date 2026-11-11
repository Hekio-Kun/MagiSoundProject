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
import group03.magisound.media.service.FileStorageService;
import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.entity.TrackSubmission;
import group03.magisound.moderation.repository.TrackSubmissionRepository;
import group03.magisound.notification.entity.NotificationType;
import group03.magisound.notification.service.NotificationService;
import group03.magisound.studio.dto.request.CreateTrackRequest;
import group03.magisound.studio.dto.request.UpdateTrackRequest;
import group03.magisound.studio.dto.response.MyTracksBundleResponse;
import group03.magisound.studio.dto.response.StudioTrackResponse;
import group03.magisound.studio.dto.response.TrackUpdateResponse;
import group03.magisound.studio.dto.response.TrackUploadResponse;
import group03.magisound.studio.mapper.StudioTrackMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.text.Normalizer;
import java.util.List;
import java.util.Locale;
import java.util.regex.Pattern;

/**
 * Service xử lý các nghiệp vụ quản lý bài hát của Tác giả theo đặc tả UC-14 (14.1 -> 14.4).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class CreatorTrackService {

    private final TrackRepository trackRepository;
    private final GenreRepository genreRepository;
    private final TrackSubmissionRepository trackSubmissionRepository;
    private final PlaylistTrackRepository playlistTrackRepository;
    private final ListeningHistoryRepository listeningHistoryRepository;
    private final AppUserRepository appUserRepository;
    private final FileStorageService fileStorageService;
    private final StudioTrackMapper studioTrackMapper;
    private final NotificationService notificationService;

    private static final Pattern NONLATIN = Pattern.compile("[^\\w-]");
    private static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    /**
     * Tải lên bài hát mới theo UC-14.1 (Upload Track).
     */
    @Transactional
    public TrackUploadResponse uploadTrack(MultipartFile audioFile, MultipartFile coverArt, CreateTrackRequest request, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);

        validateMediaFiles(audioFile, coverArt);

        Genre genre = genreRepository.findById(request.genreId())
                .orElseThrow(() -> new BadRequestOperationException("Selected genre is invalid."));
        if (!Boolean.TRUE.equals(genre.getIsActive())) {
            throw new BadRequestOperationException("Selected genre is currently inactive.");
        }

        StoredAudioResponse audioResponse = fileStorageService.saveAudioFile(audioFile, user.getId());
        StoredMediaResponse coverResponse = fileStorageService.saveCoverArt(coverArt, user.getId());

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
        StudioTrackResponse studioResponse = studioTrackMapper.toStudioTrackResponse(savedTrack, genre, null);
        return TrackUploadResponse.fromStudioTrack(studioResponse);
    }

    /**
     * Lấy danh sách bài hát của tác giả theo UC-14.2 (View My Tracks List).
     */
    @Transactional(readOnly = true)
    public MyTracksBundleResponse getMyTracks(String currentUserEmail, Pageable pageable, String statusFilter) {
        AppUser user = getAuthenticatedUser(currentUserEmail);

        Page<Track> page;
        if (statusFilter == null || statusFilter.isBlank() || "ALL".equalsIgnoreCase(statusFilter)) {
            page = trackRepository.findByUploaderUserIdOrderByCreatedAtDesc(user.getId(), pageable);
        } else {
            try {
                String normalizedFilter = statusFilter.trim().toUpperCase(Locale.ROOT);
                if ("APPROVED".equals(normalizedFilter)) {
                    normalizedFilter = "PUBLISHED";
                }
                TrackPublicationStatus status = TrackPublicationStatus.valueOf(normalizedFilter);
                page = trackRepository.findByUploaderUserIdAndPublicationStatusOrderByCreatedAtDesc(user.getId(), status, pageable);
            } catch (IllegalArgumentException ex) {
                page = trackRepository.findByUploaderUserIdOrderByCreatedAtDesc(user.getId(), pageable);
            }
        }

        List<StudioTrackResponse> items = page.getContent().stream().map(track -> {
            Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
            TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);
            return studioTrackMapper.toStudioTrackResponse(track, genre, submission);
        }).toList();

        return new MyTracksBundleResponse(items, page.getTotalElements(), page.getTotalPages(), page.getNumber());
    }

    /**
     * Cập nhật thông tin bài hát theo UC-14.3 (Update Track Metadata).
     */
    @Transactional
    public TrackUpdateResponse updateTrack(Long trackId, UpdateTrackRequest request, MultipartFile audioFile, MultipartFile coverArt, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(trackId, user.getId())
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

        if (audioFile != null && !audioFile.isEmpty()) {
            StoredAudioResponse audioResponse = fileStorageService.saveAudioFile(audioFile, user.getId());
            fileStorageService.deleteMediaFiles(track.getAudioPublicId(), null);

            track.setAudioPublicId(audioResponse.publicId());
            track.setAudioUrl(audioResponse.secureUrl());
            track.setAudioFormat(audioResponse.format() != null ? audioResponse.format() : "mp3");
            track.setDurationMs(request.durationMs() != null && request.durationMs() > 0
                    ? request.durationMs()
                    : (audioResponse.durationMs() != null ? audioResponse.durationMs() : track.getDurationMs()));
        } else if (request.durationMs() != null && request.durationMs() > 0) {
            track.setDurationMs(request.durationMs());
        }

        if (coverArt != null && !coverArt.isEmpty()) {
            StoredMediaResponse coverResponse = fileStorageService.saveCoverArt(coverArt, user.getId());
            fileStorageService.deleteMediaFiles(null, track.getCoverPublicId());

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
        StudioTrackResponse studioResponse = studioTrackMapper.toStudioTrackResponse(updatedTrack, genre, null);
        return TrackUpdateResponse.fromStudioTrack(studioResponse);
    }

    /**
     * Xóa bài hát theo UC-14.4 (Delete Track).
     */
    @Transactional
    public void deleteTrack(Long trackId, String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        Track track = trackRepository.findByIdAndUploaderUserId(trackId, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Track not found or access denied."));

        playlistTrackRepository.deleteByTrack_Id(track.getId());
        listeningHistoryRepository.deleteByTrackId(track.getId());
        trackSubmissionRepository.deleteByTrackId(track.getId());
        fileStorageService.deleteMediaFiles(track.getAudioPublicId(), track.getCoverPublicId());

        trackRepository.delete(track);
    }

    private void validateMediaFiles(MultipartFile audioFile, MultipartFile coverArt) {
        if (audioFile == null || audioFile.isEmpty()) {
            throw new BadRequestOperationException("Audio file is required to upload a track.");
        }
        if (audioFile.getSize() > 50L * 1024 * 1024) {
            throw new BadRequestOperationException("Audio file must be under 50MB.");
        }
        if (coverArt != null && !coverArt.isEmpty() && coverArt.getSize() > 10L * 1024 * 1024) {
            throw new BadRequestOperationException("Cover image must be under 10MB.");
        }
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
