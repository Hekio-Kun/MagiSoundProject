package group03.magisound.library.controller;

import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.library.service.FavoriteService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * REST Controller cho tính năng Quản lý bài hát yêu thích (UC-12: Favorite Tracks Management).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/favorites")
@PreAuthorize("isAuthenticated()")
@RequiredArgsConstructor
public class FavoriteController {

    private final FavoriteService favoriteService;

    /**
     * Lấy danh sách toàn bộ bài hát yêu thích của người dùng hiện tại (UC-12.3: View Favorite Tracks List).
     */
    @GetMapping
    public ResponseEntity<List<TrackResponse>> getMyFavorites(Authentication authentication) {
        log.info("User {} requested to view favorite tracks list", authentication.getName());
        List<TrackResponse> favorites = favoriteService.getFavoriteTracks(authentication.getName());
        return ResponseEntity.ok(favorites);
    }

    /**
     * Thêm một bài hát vào danh sách yêu thích của người dùng (UC-12.1: Add Track to Favorites).
     */
    @PostMapping("/{trackId}")
    public ResponseEntity<Map<String, Object>> addFavorite(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        log.info("User {} requested to add track ID {} to favorites", authentication.getName(), trackId);
        favoriteService.addFavorite(authentication.getName(), trackId);
        return ResponseEntity.ok(Map.of(
                "message", "Track added to favorites successfully.",
                "trackId", trackId
        ));
    }

    /**
     * Xóa một bài hát khỏi danh sách yêu thích của người dùng (UC-12.2: Remove Song from Favorites List).
     */
    @DeleteMapping("/{trackId}")
    public ResponseEntity<Map<String, Object>> removeFavorite(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        log.info("User {} requested to remove track ID {} from favorites", authentication.getName(), trackId);
        favoriteService.removeFavorite(authentication.getName(), trackId);
        return ResponseEntity.ok(Map.of(
                "message", "Track removed from favorites successfully.",
                "trackId", trackId
        ));
    }
}
