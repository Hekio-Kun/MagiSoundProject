package group03.magisound.admin.dto.response;

/**
 * DTO đại diện cho một bài hát trong danh sách Top thịnh hành / lượt nghe cao nhất (UC-22).
 */
public record TopTrackStatisticResponse(
        Long id,
        String title,
        String uploaderName,
        String genreName,
        Long playCount,
        String coverUrl,
        Integer durationMs
) {}
