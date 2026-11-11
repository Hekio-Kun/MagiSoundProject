package group03.magisound.catalog.repository;

import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TrackRepository extends JpaRepository<Track, Long> {
    Optional<Track> findByIdAndPublicationStatus(Long id, TrackPublicationStatus publicationStatus);

    default Optional<Track> findByIdAndStatus(Long id, TrackPublicationStatus status) {
        return findByIdAndPublicationStatus(id, status);
    }

    Optional<Track> findBySlugAndPublicationStatus(String slug, TrackPublicationStatus publicationStatus);

    Page<Track> findByPublicationStatus(TrackPublicationStatus publicationStatus, Pageable pageable);

    Optional<Track> findBySlug(String slug);

    List<Track> findByUploaderUserIdOrderByCreatedAtDesc(Long uploaderUserId);

    Page<Track> findByUploaderUserIdOrderByCreatedAtDesc(Long uploaderUserId, Pageable pageable);

    List<Track> findByUploaderUserIdAndPublicationStatusOrderByCreatedAtDesc(Long uploaderUserId, TrackPublicationStatus publicationStatus);

    Page<Track> findByUploaderUserIdAndPublicationStatusOrderByCreatedAtDesc(Long uploaderUserId, TrackPublicationStatus publicationStatus, Pageable pageable);

    Optional<Track> findByIdAndUploaderUserId(Long id, Long uploaderUserId);

    long countByUploaderUserId(Long uploaderUserId);

    long countByUploaderUserIdAndPublicationStatus(Long uploaderUserId, TrackPublicationStatus publicationStatus);

    long countByPublicationStatus(TrackPublicationStatus publicationStatus);

    long countByPublicationStatusAndCreatedAtAfter(TrackPublicationStatus publicationStatus, LocalDateTime after);

    @Query("SELECT COALESCE(SUM(t.playCountCache), 0) FROM Track t WHERE t.publicationStatus = 'PUBLISHED'")
    Long sumPlayCountCache();

    @Query("SELECT COUNT(DISTINCT t.uploaderUserId) FROM Track t WHERE t.publicationStatus = 'PUBLISHED'")
    Long countDistinctUploaders();

    @Query("SELECT t FROM Track t WHERE t.publicationStatus = :status ORDER BY t.playCountCache DESC")
    List<Track> findTopTracksByPlayCount(@Param("status") TrackPublicationStatus status, Pageable pageable);

    boolean existsBySlug(String slug);

    boolean existsByGenre_Id(Long genreId);

    @Modifying
    @Query("UPDATE Track t SET t.playCountCache = t.playCountCache + 1 WHERE t.id = :id")
    void incrementPlayCount(@Param("id") Long id);

    @Query("SELECT t.playCountCache FROM Track t WHERE t.id = :id")
    Optional<Long> getPlayCountById(@Param("id") Long id);
}
