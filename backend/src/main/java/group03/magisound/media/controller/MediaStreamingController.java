package group03.magisound.media.controller;

import group03.magisound.media.service.MediaStreamingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.support.ResourceRegion;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Map;

/**
 * Controller phát luồng âm thanh theo đặc tả Sequence Diagram UC-09 (Play Music).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/media")
@RequiredArgsConstructor
public class MediaStreamingController {

    private final MediaStreamingService mediaStreamingService;

    /**
     * Phát luồng đoạn âm thanh (HTTP 206 Partial Content).
     */
    @GetMapping("/stream/{trackId}")
    public ResponseEntity<ResourceRegion> streamAudio(
            @PathVariable Long trackId,
            @RequestHeader(value = "Range", required = false) String rangeHeader
    ) throws IOException {
        ResourceRegion region = mediaStreamingService.streamAudioRegion(trackId, rangeHeader);
        return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT)
                .contentType(MediaType.parseMediaType("audio/mpeg"))
                .header(HttpHeaders.ACCEPT_RANGES, "bytes")
                .body(region);
    }

    /**
     * Ghi nhận sự kiện phát nhạc hợp lệ khi nghe đủ 30 giây (BR-08).
     */
    @PostMapping("/tracks/{trackId}/play-events")
    public ResponseEntity<Map<String, Object>> recordPlayEvent(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        String userEmail = authentication != null ? authentication.getName() : null;
        mediaStreamingService.recordValidPlay(trackId, userEmail);
        return ResponseEntity.ok(Map.of("trackId", trackId, "recorded", true));
    }
}
