package group03.magisound.studio.dto.request;

import jakarta.validation.constraints.Size;

public record SubmitTrackRequest(
        @Size(max = 2000, message = "Submitter note cannot exceed 2000 characters")
        String submitterNote
) {
}
