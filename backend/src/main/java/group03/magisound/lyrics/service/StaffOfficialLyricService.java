package group03.magisound.lyrics.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.lyrics.dto.request.SaveOfficialLyricRequest;
import group03.magisound.lyrics.dto.response.LyricDetailResponse;
import group03.magisound.lyrics.dto.response.StaffTrackLyricSummaryResponse;
import group03.magisound.lyrics.entity.OfficialLyric;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class StaffOfficialLyricService {

    private final OfficialLyricRepository officialLyricRepository;
    private final TrackRepository trackRepository;
    private final AppUserRepository userRepository;
    private final UserProfileRepository userProfileRepository;

    /**
     * Lấy danh sách bài hát có kèm thông tin trạng thái lyric chính thức cho Staff quản lý.
     */
    @Transactional(readOnly = true)
    public Page<StaffTrackLyricSummaryResponse> getTracksForStaffLyricManagement(String search, Pageable pageable) {
        Page<Track> tracksPage = trackRepository.findByPublicationStatus(TrackPublicationStatus.PUBLISHED, pageable);

        if (tracksPage.isEmpty()) {
            return Page.empty(pageable);
        }

        List<Long> trackIds = tracksPage.getContent().stream().map(Track::getId).toList();
        Map<Long, OfficialLyric> lyricMap = officialLyricRepository.findByTrackIdIn(trackIds).stream()
                .collect(Collectors.toMap(l -> l.getTrack().getId(), l -> l, (a, b) -> a));

        Set<Long> uploaderIds = tracksPage.getContent().stream()
                .map(Track::getUploaderUserId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Long, String> uploaderNameMap = new HashMap<>();
        for (Long uid : uploaderIds) {
            userProfileRepository.findByUserId(uid)
                    .ifPresent(p -> uploaderNameMap.put(uid, p.getDisplayName() != null ? p.getDisplayName() : p.getUsername()));
        }

        List<StaffTrackLyricSummaryResponse> content = tracksPage.getContent().stream().map(track -> {
            OfficialLyric lyric = lyricMap.get(track.getId());
            boolean hasLyric = lyric != null;
            String lyricStatus = lyric != null ? lyric.getStatus() : null;
            Instant lyricUpdatedAt = lyric != null ? lyric.getUpdatedAt() : null;
            String genreName = track.getGenre() != null ? track.getGenre().getName() : "Unassigned";
            String uploaderName = track.getUploaderUserId() != null
                    ? uploaderNameMap.getOrDefault(track.getUploaderUserId(), "Unknown Artist")
                    : "Unknown Artist";

            return new StaffTrackLyricSummaryResponse(
                    track.getId(),
                    track.getTitle(),
                    track.getSlug(),
                    track.getCoverUrl(),
                    track.getAudioUrl(),
                    formatDuration(track.getDurationMs()),
                    genreName,
                    uploaderName,
                    hasLyric,
                    lyricStatus,
                    lyricUpdatedAt
            );
        }).toList();

        return new PageImpl<>(content, pageable, tracksPage.getTotalElements());
    }

    /**
     * Tạo mới hoặc lưu lời bài hát chính thức.
     */
    @Transactional
    public LyricDetailResponse saveOrUpdateOfficialLyric(String staffEmail, SaveOfficialLyricRequest request) {
        AppUser staff = userRepository.findByEmailIgnoreCase(staffEmail)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff account not found"));

        Track track = trackRepository.findById(request.trackId())
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + request.trackId()));

        String status = request.status().toUpperCase();
        if (!"DRAFT".equals(status) && !"PUBLISHED".equals(status)) {
            throw new BadRequestOperationException("INVALID_STATUS", "Status must be either DRAFT or PUBLISHED");
        }

        String content = request.lyricContent().trim();
        if (content.isEmpty()) {
            throw new BadRequestOperationException("EMPTY_LYRICS", "Lyrics content cannot be blank");
        }

        Optional<OfficialLyric> existingOpt = officialLyricRepository.findByTrackId(request.trackId());
        OfficialLyric lyric;
        if (existingOpt.isPresent()) {
            lyric = existingOpt.get();
            lyric.setLyricContent(content);
            lyric.setStatus(status);
            lyric.setCreatedBy(staff);
            lyric.setUpdatedAt(Instant.now());
        } else {
            lyric = OfficialLyric.builder()
                    .track(track)
                    .lyricContent(content)
                    .status(status)
                    .createdBy(staff)
                    .build();
        }

        OfficialLyric saved = officialLyricRepository.save(lyric);
        log.info("Official lyric saved id={} for trackId={} by staff={} status={}",
                saved.getId(), track.getId(), staff.getEmail(), status);

        return mapToResponse(saved);
    }

    /**
     * Cập nhật trạng thái DRAFT <-> PUBLISHED của lời bài hát chính thức.
     */
    @Transactional
    public LyricDetailResponse updateStatus(String staffEmail, Long trackId, String newStatus) {
        AppUser staff = userRepository.findByEmailIgnoreCase(staffEmail)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff account not found"));

        OfficialLyric lyric = officialLyricRepository.findByTrackId(trackId)
                .orElseThrow(() -> new ResourceNotFoundException("LYRIC_NOT_FOUND", "Official lyric not found for track id: " + trackId));

        String status = newStatus.toUpperCase();
        if (!"DRAFT".equals(status) && !"PUBLISHED".equals(status)) {
            throw new BadRequestOperationException("INVALID_STATUS", "Status must be either DRAFT or PUBLISHED");
        }

        lyric.setStatus(status);
        lyric.setCreatedBy(staff);
        lyric.setUpdatedAt(Instant.now());
        OfficialLyric saved = officialLyricRepository.save(lyric);

        log.info("Updated official lyric status to {} for trackId={} by staff={}", status, trackId, staff.getEmail());
        return mapToResponse(saved);
    }

    /**
     * Xóa lời bài hát chính thức của bài hát.
     */
    @Transactional
    public void deleteOfficialLyric(String staffEmail, Long trackId) {
        AppUser staff = userRepository.findByEmailIgnoreCase(staffEmail)
                .orElseThrow(() -> new ResourceNotFoundException("STAFF_NOT_FOUND", "Staff account not found"));

        officialLyricRepository.findByTrackId(trackId).ifPresent(lyric -> {
            officialLyricRepository.delete(lyric);
            log.info("Deleted official lyric for trackId={} by staff={}", trackId, staff.getEmail());
        });
    }

    private LyricDetailResponse mapToResponse(OfficialLyric lyric) {
        return new LyricDetailResponse(
                lyric.getId(),
                lyric.getTrack().getId(),
                lyric.getLyricContent(),
                lyric.getStatus(),
                true,
                "OFFICIAL",
                lyric.getUpdatedAt()
        );
    }

    private String formatDuration(Integer durationMs) {
        if (durationMs == null || durationMs <= 0) return "0:00";
        int totalSec = durationMs / 1000;
        int min = totalSec / 60;
        int sec = totalSec % 60;
        return String.format("%d:%02d", min, sec);
    }
}
