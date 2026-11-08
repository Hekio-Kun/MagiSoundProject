package group03.magisound.lyrics.dto.response;

public record TrackLyricsBundleResponse(
    LyricDetailResponse officialLyric,
    LyricDetailResponse userPersonalLyric
) {}
