package group03.magisound.moderation.repository;

import group03.magisound.moderation.entity.ContentReport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContentReportRepository extends JpaRepository<ContentReport, Long> {

    List<ContentReport> findByReporterIdAndTargetTypeAndTargetId(Long reporterId, String targetType, Long targetId);

    Page<ContentReport> findByTargetTypeAndStatus(String targetType, String status, Pageable pageable);

    Page<ContentReport> findByStatusIgnoreCase(String status, Pageable pageable);

    List<ContentReport> findAllByOrderByCreatedAtDesc();

    List<ContentReport> findByTargetIdAndStatus(Long targetId, String status);

    List<ContentReport> findByReviewerIdOrderByResolvedAtDesc(Long reviewerId);

    List<ContentReport> findByHandledByUserIdOrderByHandledAtDesc(Long handledByUserId);

    long countByStatus(String status);

    long countByStatusIgnoreCase(String status);

    List<ContentReport> findBySubmittedByUserIdOrderByCreatedAtDesc(Long submittedByUserId);

    List<ContentReport> findByTrackIdAndStatusIgnoreCase(Long trackId, String status);

    @Query("SELECT c FROM ContentReport c WHERE c.submittedByUserId = :userId OR c.reporterId = :userId ORDER BY c.createdAt DESC")
    List<ContentReport> findMyReports(@Param("userId") Long userId);

    @Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM ContentReport c " +
           "WHERE (c.trackId = :trackId OR (c.targetType = 'TRACK' AND c.targetId = :trackId)) " +
           "AND (c.submittedByUserId = :userId OR c.reporterId = :userId) " +
           "AND UPPER(c.status) = UPPER(:status)")
    boolean hasPendingReportForTrack(
            @Param("trackId") Long trackId,
            @Param("userId") Long userId,
            @Param("status") String status
    );
}
