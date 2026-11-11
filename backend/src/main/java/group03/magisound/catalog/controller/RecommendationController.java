package group03.magisound.catalog.controller;

import group03.magisound.catalog.dto.response.RecommendedTracksBundleResponse;
import group03.magisound.catalog.service.RecommendationService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller phục vụ danh mục gợi ý theo đặc tả Sequence Diagram UC-06 (View Recommended Songs).
 */
@Slf4j
@RestController
@RequestMapping({"/api/v1/catalog/recommendations", "/api/v1/recommendations"})
@RequiredArgsConstructor
public class RecommendationController {

    private final RecommendationService recommendationService;

    @GetMapping
    public ResponseEntity<RecommendedTracksBundleResponse> getRecommendations(
            @RequestParam(required = false, defaultValue = "20") int limit,
            Authentication authentication
    ) {
        String userId = authentication != null ? authentication.getName() : null;
        log.info("Fetching recommendations for userId={}, limit={}", userId, limit);
        RecommendedTracksBundleResponse response = recommendationService.getRecommendations(userId, limit);
        return ResponseEntity.ok(response);
    }
}
