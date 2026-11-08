package group03.magisound.library.service;

import group03.magisound.authentication.dto.response.UserProfileSummary;
import group03.magisound.authentication.service.UserAccountPublicService;
import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.service.TrackCatalogPublicService;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.library.entity.Favorite;
import group03.magisound.library.entity.FavoriteId;
import group03.magisound.library.repository.FavoriteRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Service xử lý nghiệp vụ Quản lý bài hát yêu thích (UC-12: Favorite Tracks Management).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;
    private final TrackCatalogPublicService trackCatalogPublicService;
    private final UserAccountPublicService userAccountPublicService;

    /**
     * Thêm một bài hát vào danh sách yêu thích của người dùng (UC-12.1: Add Track to Favorites).
     */
    @Transactional
    public void addFavorite(String currentUserEmail, Long trackId) {
        if (trackId == null || trackId <= 0) {
            throw new BadRequestOperationException("INVALID_TRACK_ID", "Track ID must be a valid positive number.");
        }

        Long userId = userAccountPublicService.getUserIdByEmail(currentUserEmail);
        trackCatalogPublicService.validatePublishedTrack(trackId);

        FavoriteId favoriteId = new FavoriteId(userId, trackId);
        if (favoriteRepository.existsById(favoriteId)) {
            log.info("Track ID {} is already in favorites for user ID {}", trackId, userId);
            return;
        }

        Favorite favorite = new Favorite(userId, trackId);
        favoriteRepository.save(favorite);
        log.info("Successfully added track ID {} to favorites for user ID {}", trackId, userId);
    }

    /**
     * Xóa một bài hát khỏi danh sách yêu thích của người dùng (UC-12.2: Remove Song from Favorites List).
     */
    @Transactional
    public void removeFavorite(String currentUserEmail, Long trackId) {
        if (trackId == null || trackId <= 0) {
            throw new BadRequestOperationException("INVALID_TRACK_ID", "Track ID must be a valid positive number.");
        }

        Long userId = userAccountPublicService.getUserIdByEmail(currentUserEmail);

        FavoriteId favoriteId = new FavoriteId(userId, trackId);
        if (!favoriteRepository.existsById(favoriteId)) {
            log.info("Track ID {} is already absent from favorites for user ID {}", trackId, userId);
            return;
        }

        favoriteRepository.deleteById(favoriteId);
        log.info("Successfully removed track ID {} from favorites for user ID {}", trackId, userId);
    }

    /**
     * Lấy danh sách toàn bộ bài hát yêu thích của người dùng hiện tại (UC-12.3: View Favorite Tracks List).
     */
    @Transactional(readOnly = true)
    public List<TrackResponse> getFavoriteTracks(String currentUserEmail) {
        Long userId = userAccountPublicService.getUserIdByEmail(currentUserEmail);

        List<Favorite> favorites = favoriteRepository.findFavoritesByUserIdAndPublicationStatus(
                userId, TrackPublicationStatus.PUBLISHED
        );

        if (favorites.isEmpty()) {
            return Collections.emptyList();
        }

        Set<Long> creatorIds = favorites.stream()
                .map(Favorite::getTrack)
                .filter(Objects::nonNull)
                .map(Track::getUploaderUserId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Long, UserProfileSummary> creatorSummaries =
                userAccountPublicService.getUserSummariesByIds(creatorIds);

        return favorites.stream()
                .map(Favorite::getTrack)
                .filter(Objects::nonNull)
                .map(track -> mapToTrackResponse(track, creatorSummaries))
                .toList();
    }

    private TrackResponse mapToTrackResponse(
            Track track,
            Map<Long, UserProfileSummary> creatorSummaries
    ) {
        UserProfileSummary creator = creatorSummaries.get(track.getUploaderUserId());
        TrackResponse.TrackCreatorSummary creatorSummary =
                new TrackResponse.TrackCreatorSummary(
                        track.getUploaderUserId(),
                        creator != null && creator.displayName() != null ? creator.displayName() : "Unknown Artist",
                        creator != null ? creator.avatarUrl() : null
                );

        return new TrackResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getAudioUrl(),
                track.getCoverUrl(),
                track.getDurationMs(),
                track.getPlayCountCache() != null ? track.getPlayCountCache() : 0L,
                track.getPublicationStatus().name(),
                track.getGenre() != null ? track.getGenre().getSlug() : null,
                track.getGenre() != null ? track.getGenre().getName() : null,
                null, // No Album in MagiSound
                creatorSummary,
                track.getCreatedAt()
        );
    }
}
