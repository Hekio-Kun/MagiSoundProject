package group03.magisound.studio.dto.response;

import java.time.Instant;

/**
 * DTO phản hồi cập nhật thông tin bài hát (UC-14.3 - Update Track Metadata).
 */
public record TrackUpdateResponse(
        Long id,
        String title,
        String slug,
        String description,
        Long genreId,
        String genreName,
        Integer trackNumber,
        String status,
        String audioUrl,
        String coverUrl,
        Integer durationMs,
        String lyrics,
        Instant updatedAt
) {
    public static TrackUpdateResponse fromStudioTrack(StudioTrackResponse studio) {
        if (studio == null) return null;
        return new TrackUpdateResponse(
                studio.id(),
                studio.title(),
                studio.slug(),
                studio.description(),
                studio.genreId(),
                studio.genreName(),
                studio.trackNumber(),
                studio.status(),
                studio.audioUrl(),
                studio.coverUrl(),
                studio.durationMs(),
                studio.lyrics(),
                studio.updatedAt()
        );
    }
}
