package group03.magisound.studio.dto.response;

import java.time.Instant;

/**
 * DTO phản hồi sau khi tải lên bài hát thành công (UC-14.1 - Upload Track).
 */
public record TrackUploadResponse(
        Long id,
        String title,
        String slug,
        String description,
        Long genreId,
        String genreName,
        String genreSlug,
        Long albumId,
        String albumTitle,
        Integer trackNumber,
        String status,
        String audioUrl,
        String audioFormat,
        Integer durationMs,
        String coverUrl,
        Long playCount,
        Instant createdAt,
        String lyrics
) {
    public static TrackUploadResponse fromStudioTrack(StudioTrackResponse studio) {
        if (studio == null) return null;
        return new TrackUploadResponse(
                studio.id(),
                studio.title(),
                studio.slug(),
                studio.description(),
                studio.genreId(),
                studio.genreName(),
                studio.genreSlug(),
                studio.albumId(),
                studio.albumTitle(),
                studio.trackNumber(),
                studio.status(),
                studio.audioUrl(),
                studio.audioFormat(),
                studio.durationMs(),
                studio.coverUrl(),
                studio.playCount(),
                studio.createdAt(),
                studio.lyrics()
        );
    }
}
