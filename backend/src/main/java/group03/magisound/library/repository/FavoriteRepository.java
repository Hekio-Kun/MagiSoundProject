package group03.magisound.library.repository;

import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.library.entity.Favorite;
import group03.magisound.library.entity.FavoriteId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Repository truy xuất dữ liệu bài hát yêu thích từ bảng favorites (UC-12).
 */
@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, FavoriteId> {

    boolean existsByIdUserIdAndIdTrackId(Long userId, Long trackId);

    Optional<Favorite> findByIdUserIdAndIdTrackId(Long userId, Long trackId);

    void deleteByIdUserIdAndIdTrackId(Long userId, Long trackId);

    List<Favorite> findByIdUserIdOrderByCreatedAtDesc(Long userId);

    long countByIdUserId(Long userId);

    @Query("SELECT f FROM Favorite f " +
            "JOIN FETCH f.track t " +
            "LEFT JOIN FETCH t.genre " +
            "WHERE f.id.userId = :userId AND t.publicationStatus = :status " +
            "ORDER BY f.createdAt DESC")
    List<Favorite> findFavoritesByUserIdAndPublicationStatus(
            @Param("userId") Long userId,
            @Param("status") TrackPublicationStatus status
    );
}
