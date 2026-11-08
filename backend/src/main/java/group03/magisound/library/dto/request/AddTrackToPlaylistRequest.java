package group03.magisound.library.dto.request;

import jakarta.validation.constraints.NotNull;

public record AddTrackToPlaylistRequest(
        @NotNull(message = "Track ID is required.")
        Long trackId
) {}
