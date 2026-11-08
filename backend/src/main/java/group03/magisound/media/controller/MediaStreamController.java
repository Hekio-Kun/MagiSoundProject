package group03.magisound.media.controller;

import group03.magisound.media.service.InternalMediaService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.ResourceRegion;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@Slf4j
@RestController
@RequestMapping("/api/media")
@RequiredArgsConstructor
public class MediaStreamController {

    private final InternalMediaService mediaService;

    /**
     * HTTP Byte-Range Audio Streaming according to RFC 7233 (Status 206 Partial Content).
     * Enables instant seek and audio playback in browser without loading full file.
     */
    @GetMapping("/stream/{filename}")
    public ResponseEntity<ResourceRegion> streamAudio(
            @PathVariable String filename,
            @RequestHeader(value = "Range", required = false) String rangeHeader
    ) throws IOException {
        Resource audioResource = mediaService.loadAudioResource(filename);
        long contentLength = audioResource.contentLength();

        MediaType mediaType = MediaType.parseMediaType("audio/mpeg");
        if (filename.endsWith(".wav")) {
            mediaType = MediaType.parseMediaType("audio/wav");
        } else if (filename.endsWith(".flac")) {
            mediaType = MediaType.parseMediaType("audio/flac");
        }

        if (rangeHeader == null || rangeHeader.isBlank()) {
            ResourceRegion region = new ResourceRegion(audioResource, 0, Math.min(1024 * 1024L, contentLength));
            return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT)
                    .contentType(mediaType)
                    .header(HttpHeaders.ACCEPT_RANGES, "bytes")
                    .body(region);
        }

        HttpRange range = HttpRange.parseRanges(rangeHeader).get(0);
        long start = range.getRangeStart(contentLength);
        long end = range.getRangeEnd(contentLength);
        long rangeLength = Math.min(1024 * 1024L, end - start + 1);

        ResourceRegion region = new ResourceRegion(audioResource, start, rangeLength);
        return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT)
                .contentType(mediaType)
                .header(HttpHeaders.ACCEPT_RANGES, "bytes")
                .body(region);
    }

    @GetMapping("/cover/{filename}")
    public ResponseEntity<Resource> getCoverImage(@PathVariable String filename) {
        Resource cover = mediaService.loadCoverResource(filename);
        MediaType mediaType = MediaType.IMAGE_JPEG;
        if (filename.endsWith(".png")) {
            mediaType = MediaType.IMAGE_PNG;
        } else if (filename.endsWith(".webp")) {
            mediaType = MediaType.parseMediaType("image/webp");
        }
        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(HttpHeaders.CACHE_CONTROL, "public, max-age=86400")
                .body(cover);
    }

    @GetMapping("/avatar/{filename}")
    public ResponseEntity<Resource> getAvatarImage(@PathVariable String filename) {
        Resource avatar = mediaService.loadAvatarResource(filename);
        MediaType mediaType = MediaType.IMAGE_JPEG;
        if (filename.endsWith(".png")) {
            mediaType = MediaType.IMAGE_PNG;
        } else if (filename.endsWith(".webp")) {
            mediaType = MediaType.parseMediaType("image/webp");
        }
        return ResponseEntity.ok()
                .contentType(mediaType)
                .header(HttpHeaders.CACHE_CONTROL, "public, max-age=86400")
                .body(avatar);
    }
}
