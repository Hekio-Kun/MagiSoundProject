package group03.magisound.moderation.repository;

import group03.magisound.moderation.entity.SubmissionStatus;
import group03.magisound.moderation.entity.TrackSubmission;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Repository truy vấn dữ liệu cho bảng yêu cầu kiểm duyệt bài hát (track_submissions).
 * Phục vụ các nghiệp vụ tra cứu và cập nhật trạng thái kiểm duyệt [UC-17: Manage Track Moderation].
 */
@Repository
public interface TrackSubmissionRepository extends JpaRepository<TrackSubmission, Long> {

    Optional<TrackSubmission> findFirstByTrackIdOrderBySubmittedAtDesc(Long trackId);
    List<TrackSubmission> findByTrackIdOrderBySubmittedAtDesc(Long trackId);
    List<TrackSubmission> findByReviewerUserIdOrderByReviewedAtDesc(Long reviewerUserId);
    void deleteByTrackId(Long trackId);

    @Query("SELECT s.reviewerUserId, COUNT(s) FROM TrackSubmission s " +
           "WHERE s.reviewerUserId IN :reviewerIds AND s.status IN :statuses " +
           "GROUP BY s.reviewerUserId")
    List<Object[]> countByReviewerUserIdsAndStatusIn(
            @Param("reviewerIds") Collection<Long> reviewerIds,
            @Param("statuses") Collection<SubmissionStatus> statuses);

    long countByStatus(SubmissionStatus status);

    Page<TrackSubmission> findByStatus(SubmissionStatus status, Pageable pageable);

    @Query("SELECT s FROM TrackSubmission s WHERE (:status IS NULL OR s.status = :status) " +
           "AND (s.trackId IN :trackIds OR s.submittedByUserId IN :userIds)")
    Page<TrackSubmission> findByStatusAndMatchingIds(
            @Param("status") SubmissionStatus status,
            @Param("trackIds") Collection<Long> trackIds,
            @Param("userIds") Collection<Long> userIds,
            Pageable pageable);
}
