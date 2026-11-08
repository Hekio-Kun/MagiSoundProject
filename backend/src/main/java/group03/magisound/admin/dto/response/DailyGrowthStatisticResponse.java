package group03.magisound.admin.dto.response;

/**
 * DTO đại diện cho một điểm dữ liệu trên biểu đồ tăng trưởng người dùng (UC-22).
 */
public record DailyGrowthStatisticResponse(
        String label,
        String date,
        long count
) {}
