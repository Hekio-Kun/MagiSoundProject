package group03.magisound.library.dto.response;

import group03.magisound.catalog.dto.response.TrackResponse;

import java.time.LocalDateTime;
import java.util.List;

public record PlaylistResponse(
        Long id,
        String title,
        String slug,
        String description,
        String coverUrl,
        boolean isPrivate,
        Long ownerId,
        String ownerName,
        String creatorName,
        int trackCount,
        long totalDurationMs,
        List<Long> trackIds,
        List<TrackResponse> tracks,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
