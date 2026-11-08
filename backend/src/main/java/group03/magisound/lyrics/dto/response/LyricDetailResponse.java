package group03.magisound.lyrics.dto.response;

import java.time.Instant;

public record LyricDetailResponse(
    Long id,
    Long trackId,
    String lyricContent,
    String status,
    boolean isOfficial,
    String lyricType,
    Instant updatedAt
) {}
