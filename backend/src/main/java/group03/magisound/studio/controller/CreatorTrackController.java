package group03.magisound.studio.controller;

import group03.magisound.studio.dto.request.CreateTrackRequest;
import group03.magisound.studio.dto.request.UpdateTrackRequest;
import group03.magisound.studio.dto.response.MyTracksBundleResponse;
import group03.magisound.studio.dto.response.RejectionFeedbackResponse;
import group03.magisound.studio.dto.response.TrackUpdateResponse;
import group03.magisound.studio.dto.response.TrackUploadResponse;
import group03.magisound.studio.service.CreatorTrackService;
import group03.magisound.studio.service.ModerationFeedbackService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * Controller tiếp nhận các yêu cầu quản lý bài hát từ Tác giả (UC-14: Upload, View, Update, Delete & UC-15: View Rejection Reason).
 */
@RestController
@RequestMapping("/api/v1/creator")
@RequiredArgsConstructor
public class CreatorTrackController {

    private final CreatorTrackService creatorTrackService;
    private final ModerationFeedbackService moderationFeedbackService;

    /**
     * Tải lên bài hát mới theo UC-14.1 (Upload Track).
     */
    @PostMapping(value = "/tracks", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<TrackUploadResponse> uploadTrack(
            @RequestPart("track") @Valid CreateTrackRequest request,
            @RequestPart("audio") MultipartFile audio,
            @RequestPart(value = "cover", required = false) MultipartFile cover,
            Authentication authentication
    ) {
        TrackUploadResponse response = creatorTrackService.uploadTrack(
                audio, cover, request, authentication.getName()
        );
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    /**
     * Lấy danh sách bài hát của tác giả theo UC-14.2 (View My Tracks List).
     */
    @GetMapping("/tracks")
    public ResponseEntity<MyTracksBundleResponse> getMyTracks(
            @RequestParam(required = false) String status,
            @PageableDefault(size = 10, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable,
            Authentication authentication
    ) {
        MyTracksBundleResponse response = creatorTrackService.getMyTracks(
                authentication.getName(), pageable, status
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Cập nhật thông tin bài hát theo UC-14.3 (Update Track Metadata).
     */
    @PutMapping(value = "/tracks/{trackId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<TrackUpdateResponse> updateTrack(
            @PathVariable Long trackId,
            @RequestPart("track") @Valid UpdateTrackRequest request,
            @RequestPart(value = "audio", required = false) MultipartFile audio,
            @RequestPart(value = "cover", required = false) MultipartFile cover,
            Authentication authentication
    ) {
        TrackUpdateResponse response = creatorTrackService.updateTrack(
                trackId, request, audio, cover, authentication.getName()
        );
        return ResponseEntity.ok(response);
    }

    /**
     * Xóa bài hát theo UC-14.4 (Delete Track).
     */
    @DeleteMapping("/tracks/{trackId}")
    public ResponseEntity<Void> deleteTrack(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        creatorTrackService.deleteTrack(trackId, authentication.getName());
        return ResponseEntity.noContent().build();
    }

    /**
     * Xem phản hồi từ chối kiểm duyệt của bài hát theo UC-15 (View Rejection Reason).
     */
    @GetMapping("/tracks/{trackId}/rejection-reason")
    public ResponseEntity<RejectionFeedbackResponse> getRejectionFeedback(
            @PathVariable Long trackId,
            Authentication authentication
    ) {
        RejectionFeedbackResponse response = moderationFeedbackService.getRejectionFeedback(
                trackId, authentication.getName()
        );
        return ResponseEntity.ok(response);
    }
}
