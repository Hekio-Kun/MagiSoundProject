package group03.magisound.media.controller;

import group03.magisound.media.dto.response.PlaybackSyncResponse;
import group03.magisound.media.service.PlaybackService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * Controller điều khiển phát nhạc và hàng đợi theo đặc tả Sequence Diagram UC-10 (Control Playback).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/media/queue")
@RequiredArgsConstructor
public class PlaybackController {

    private final PlaybackService playbackService;

    /**
     * Chuyển bài hát tiếp theo trong hàng đợi phát nhạc (UC-10 Next Track).
     */
    @PostMapping("/next")
    public ResponseEntity<PlaybackSyncResponse> loadNextTrack(@RequestBody Map<String, Object> payload) {
        Long nextTrackId = null;
        if (payload != null && payload.containsKey("nextTrackId") && payload.get("nextTrackId") != null) {
            nextTrackId = Long.valueOf(payload.get("nextTrackId").toString());
        }
        log.info("Loading next track in queue: nextTrackId={}", nextTrackId);
        PlaybackSyncResponse response = playbackService.loadNextTrackInQueue(nextTrackId);
        return ResponseEntity.ok(response);
    }
}
