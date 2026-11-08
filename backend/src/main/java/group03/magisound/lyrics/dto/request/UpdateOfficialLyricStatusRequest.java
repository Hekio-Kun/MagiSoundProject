package group03.magisound.lyrics.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record UpdateOfficialLyricStatusRequest(
    @NotBlank(message = "Status cannot be blank")
    @Pattern(regexp = "DRAFT|PUBLISHED", message = "Status must be either DRAFT or PUBLISHED")
    String status
) {}
