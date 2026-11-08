package group03.magisound.studio.dto.response;

public record StudioStatsResponse(
        long total,
        long draft,
        long pending,
        long approved,
        long rejected
) {
}
