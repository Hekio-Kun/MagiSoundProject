package group03.magisound.media.dto.response;

/**
 * DTO phản hồi đoạn luồng âm thanh theo UC-09 (Play Music).
 */
public record AudioStreamChunkResponse(
        byte[] audioChunk,
        String contentRange,
        long contentLength
) {
}
