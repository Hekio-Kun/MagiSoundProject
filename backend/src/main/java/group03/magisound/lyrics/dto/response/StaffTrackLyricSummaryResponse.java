package group03.magisound.lyrics.dto.response;

import java.time.Instant;

public record StaffTrackLyricSummaryResponse(
    Long trackId,
    String trackTitle,
    String trackSlug,
    String coverUrl,
    String audioUrl,
    String durationFormatted,
    String genreName,
    String uploaderName,
    boolean hasOfficialLyric,
    String lyricStatus,
    Instant lyricUpdatedAt
) {}
