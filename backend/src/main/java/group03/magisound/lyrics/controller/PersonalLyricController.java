package group03.magisound.lyrics.controller;

import group03.magisound.lyrics.dto.request.CustomLyricRequest;
import group03.magisound.lyrics.dto.response.CustomLyricResponse;
import group03.magisound.lyrics.dto.response.TrackLyricsBundleResponse;
import group03.magisound.lyrics.service.LyricService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/tracks/{trackId}/lyrics")
@RequiredArgsConstructor
public class PersonalLyricController {

    private final LyricService lyricService;

    @GetMapping
    public ResponseEntity<TrackLyricsBundleResponse> getLyrics(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        String userEmail = authentication != null ? authentication.getName() : null;
        return ResponseEntity.ok(lyricService.getTrackLyrics(trackId, userEmail));
    }

    @PostMapping("/custom")
    public ResponseEntity<CustomLyricResponse> createCustomLyric(
            @PathVariable Long trackId,
            @Valid @RequestBody CustomLyricRequest request,
            Authentication authentication
    ) {
        var req = new group03.magisound.lyrics.dto.request.SavePersonalLyricRequest(request.lyricType(), request.lyricContent());
        var res = lyricService.savePersonalLyric(authentication.getName(), trackId, req);
        var customRes = new CustomLyricResponse(
                res.id(),
                res.trackId(),
                null,
                res.lyricType(),
                res.lyricContent(),
                null,
                null
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(customRes);
    }

    @PutMapping("/custom/{id}")
    public ResponseEntity<CustomLyricResponse> updateCustomLyric(
            @PathVariable Long trackId,
            @PathVariable Long id,
            @Valid @RequestBody CustomLyricRequest request,
            Authentication authentication
    ) {
        var req = new group03.magisound.lyrics.dto.request.SavePersonalLyricRequest(request.lyricType(), request.lyricContent());
        var res = lyricService.savePersonalLyric(authentication.getName(), trackId, req);
        var customRes = new CustomLyricResponse(
                res.id(),
                res.trackId(),
                null,
                res.lyricType(),
                res.lyricContent(),
                null,
                null
        );
        return ResponseEntity.ok(customRes);
    }

    @DeleteMapping("/custom/{id}")
    public ResponseEntity<Void> deleteCustomLyric(
            @PathVariable Long trackId,
            @PathVariable Long id,
            Authentication authentication
    ) {
        lyricService.deletePersonalLyric(authentication.getName(), trackId, "CUSTOM");
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/custom")
    public ResponseEntity<List<CustomLyricResponse>> getMyCustomLyrics(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        return ResponseEntity.ok(lyricService.getCustomLyricsByTrack(authentication.getName(), trackId));
    }
}
