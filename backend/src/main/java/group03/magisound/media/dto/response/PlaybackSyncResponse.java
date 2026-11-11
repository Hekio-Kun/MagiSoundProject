package group03.magisound.media.dto.response;

import group03.magisound.catalog.dto.response.TrackResponse;

/**
 * DTO đồng bộ hàng đợi phát nhạc theo UC-10 (Control Playback).
 */
public record PlaybackSyncResponse(
        Long trackId,
        String title,
        String audioUrl,
        Integer durationMs,
        String status,
        TrackResponse trackDetails
) {
}
