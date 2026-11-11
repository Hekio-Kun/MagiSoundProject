package group03.magisound.catalog.controller;

import group03.magisound.catalog.dto.response.TrackDetailResponse;
import group03.magisound.catalog.service.TrackService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller xem thông tin chi tiết bài hát theo đặc tả Sequence Diagram UC-08 (View Track Details).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/catalog/tracks")
@RequiredArgsConstructor
public class TrackController {

    private final TrackService trackService;

    @GetMapping("/{trackId}")
    public ResponseEntity<TrackDetailResponse> getTrackDetail(@PathVariable Long trackId) {
        log.info("Fetching track detail for trackId={}", trackId);
        TrackDetailResponse response = trackService.getTrackDetail(trackId);
        return ResponseEntity.ok(response);
    }
}
