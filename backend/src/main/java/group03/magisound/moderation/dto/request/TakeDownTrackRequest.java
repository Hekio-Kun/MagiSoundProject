package group03.magisound.moderation.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * DTO chứa dữ liệu yêu cầu khi gỡ bỏ bài hát đã xuất bản (UC-19 Take Down Published Track).
 */
public record TakeDownTrackRequest(
        @NotBlank(message = "Takedown reason is required")
        @Size(max = 1000, message = "Takedown reason cannot exceed 1000 characters")
        String takedownReason,

        @Size(max = 2000, message = "Reviewer note cannot exceed 2000 characters")
        String reviewerNote
) {}
