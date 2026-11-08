package group03.magisound.lyrics.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.lyrics.dto.request.SavePersonalLyricRequest;
import group03.magisound.lyrics.dto.response.CustomLyricResponse;
import group03.magisound.lyrics.dto.response.LyricDetailResponse;
import group03.magisound.lyrics.dto.response.TrackLyricsBundleResponse;
import group03.magisound.lyrics.entity.OfficialLyric;
import group03.magisound.lyrics.entity.PersonalLyric;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import group03.magisound.lyrics.repository.PersonalLyricRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class LyricService {

    private final OfficialLyricRepository officialLyricRepository;
    private final PersonalLyricRepository personalLyricRepository;
    private final TrackRepository trackRepository;
    private final AppUserRepository userRepository;

    /**
     * Lấy bundle lời bài hát cho trang chi tiết track (bao gồm Official và Personal của user hiện tại).
     */
    @Transactional(readOnly = true)
    public TrackLyricsBundleResponse getTrackLyrics(Long trackId, String currentUserEmailOrNull) {
        Track track = trackRepository.findById(trackId)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + trackId));

        LyricDetailResponse officialResponse = officialLyricRepository.findByTrackIdAndStatus(trackId, "PUBLISHED")
                .map(this::mapOfficialToResponse)
                .orElse(null);

        LyricDetailResponse personalResponse = null;
        if (currentUserEmailOrNull != null && !currentUserEmailOrNull.isBlank()) {
            Optional<AppUser> userOpt = userRepository.findByEmailIgnoreCase(currentUserEmailOrNull);
            if (userOpt.isPresent()) {
                personalResponse = personalLyricRepository
                        .findByUserIdAndTrackIdAndLyricType(userOpt.get().getId(), trackId, "CUSTOM")
                        .or(() -> personalLyricRepository.findByUserIdAndTrackIdAndLyricType(userOpt.get().getId(), trackId, "TRANSLATION"))
                        .map(this::mapPersonalToResponse)
                        .orElse(null);
            }
        }

        return new TrackLyricsBundleResponse(officialResponse, personalResponse);
    }

    @Transactional(readOnly = true)
    public TrackLyricsBundleResponse getSynchronousLyrics(Long trackId, String currentUserEmailOrNull) {
        return getTrackLyrics(trackId, currentUserEmailOrNull);
    }

    /**
     * Tạo mới hoặc cập nhật bản lyric cá nhân của User cho Track.
     */
    @Transactional
    public LyricDetailResponse savePersonalLyric(String userEmail, Long trackId, SavePersonalLyricRequest request) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        Track track = trackRepository.findById(trackId)
                .orElseThrow(() -> new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with id: " + trackId));

        String lyricType = (request.lyricType() != null && !request.lyricType().isBlank())
                ? request.lyricType().trim().toUpperCase()
                : "CUSTOM";

        if (!"CUSTOM".equals(lyricType) && !"TRANSLATION".equals(lyricType)) {
            lyricType = "CUSTOM";
        }

        String content = request.lyricContent().trim();
        if (content.isEmpty()) {
            throw new BadRequestOperationException("EMPTY_LYRICS", "Lyrics content cannot be blank");
        }

        Optional<PersonalLyric> existingOpt = personalLyricRepository
                .findByUserIdAndTrackIdAndLyricType(user.getId(), track.getId(), lyricType);

        PersonalLyric lyric;
        if (existingOpt.isPresent()) {
            lyric = existingOpt.get();
            lyric.setLyricContent(content);
        } else {
            lyric = PersonalLyric.builder()
                    .user(user)
                    .track(track)
                    .lyricType(lyricType)
                    .lyricContent(content)
                    .build();
        }

        PersonalLyric saved = personalLyricRepository.save(lyric);
        log.info("Personal lyric saved id={} for trackId={} by user={}", saved.getId(), track.getId(), user.getEmail());

        return mapPersonalToResponse(saved);
    }

    /**
     * Xóa lời bài hát cá nhân theo loại lyricType (CUSTOM hoặc TRANSLATION).
     */
    @Transactional
    public void deletePersonalLyric(String userEmail, Long trackId, String lyricType) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        String type = (lyricType != null && !lyricType.isBlank()) ? lyricType.trim().toUpperCase() : "CUSTOM";
        personalLyricRepository.deleteByUserIdAndTrackIdAndLyricType(user.getId(), trackId, type);
        log.info("Deleted personal lyric type={} for trackId={} by user={}", type, trackId, user.getEmail());
    }

    /**
     * Lấy toàn bộ các bản lyric cá nhân của User cho 1 Track cụ thể.
     */
    @Transactional(readOnly = true)
    public List<CustomLyricResponse> getCustomLyricsByTrack(String userEmail, Long trackId) {
        AppUser user = userRepository.findByEmailIgnoreCase(userEmail)
                .orElseThrow(() -> new ResourceNotFoundException("USER_NOT_FOUND", "User account not found"));

        List<PersonalLyric> list = personalLyricRepository.findByUserIdAndTrackId(user.getId(), trackId);
        return list.stream().map(this::mapPersonalToCustomLyricResponse).toList();
    }

    private LyricDetailResponse mapOfficialToResponse(OfficialLyric lyric) {
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

    private LyricDetailResponse mapPersonalToResponse(PersonalLyric lyric) {
        return new LyricDetailResponse(
                lyric.getId(),
                lyric.getTrack().getId(),
                lyric.getLyricContent(),
                "PUBLISHED",
                false,
                lyric.getLyricType(),
                lyric.getUpdatedAt()
        );
    }

    private CustomLyricResponse mapPersonalToCustomLyricResponse(PersonalLyric lyric) {
        LocalDateTime createdAt = lyric.getCreatedAt() != null
                ? LocalDateTime.ofInstant(lyric.getCreatedAt(), ZoneOffset.UTC) : null;
        LocalDateTime updatedAt = lyric.getUpdatedAt() != null
                ? LocalDateTime.ofInstant(lyric.getUpdatedAt(), ZoneOffset.UTC) : null;

        return new CustomLyricResponse(
                lyric.getId(),
                lyric.getTrack().getId(),
                lyric.getUser().getId(),
                lyric.getLyricType(),
                lyric.getLyricContent(),
                createdAt,
                updatedAt
        );
    }
}
