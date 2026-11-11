package group03.magisound.catalog.dto.response;

import group03.magisound.catalog.entity.Track;

import java.time.LocalDateTime;

/**
 * DTO chi tiết bài hát công khai theo UC-08 (View Track Details).
 */
public record TrackDetailResponse(
        Long id,
        String title,
        String slug,
        String description,
        Integer trackNumber,
        String publicationStatus,
        String audioUrl,
        String audioFormat,
        Integer durationMs,
        String coverUrl,
        Long playCount,
        LocalDateTime approvedAt,
        LocalDateTime createdAt,
        String genreName,
        String genreSlug,
        String lyrics
) {
    public static TrackDetailResponse fromTrack(Track track) {
        if (track == null) return null;
        return new TrackDetailResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getTrackNumber(),
                track.getPublicationStatus() != null ? track.getPublicationStatus().name() : null,
                track.getAudioUrl(),
                track.getAudioFormat(),
                track.getDurationMs(),
                track.getCoverUrl(),
                track.getPlayCountCache() != null ? track.getPlayCountCache() : 0L,
                track.getApprovedAt(),
                track.getCreatedAt(),
                track.getGenre() != null ? track.getGenre().getName() : null,
                track.getGenre() != null ? track.getGenre().getSlug() : null,
                track.getLyrics()
        );
    }
}
