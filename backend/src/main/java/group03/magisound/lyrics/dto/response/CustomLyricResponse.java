package group03.magisound.lyrics.dto.response;

import java.time.LocalDateTime;

public record CustomLyricResponse(
        Long id,
        Long trackId,
        Long userId,
        String lyricType,
        String lyricContent,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {}
