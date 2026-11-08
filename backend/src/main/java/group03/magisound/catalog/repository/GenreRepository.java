package group03.magisound.catalog.repository;

import group03.magisound.catalog.entity.Genre;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Locale;
import java.util.Optional;

/**
 * Repository truy vấn dữ liệu cho bảng thể loại nhạc (genres).
 * Phục vụ danh mục công khai [UC-8] và chức năng Quản lý thể loại của Admin [UC-21: Manage Genres].
 */
public interface GenreRepository extends JpaRepository<Genre, Long> {
    Optional<Genre> findBySlug(String slug);
    List<Genre> findByIsActiveTrue();
    List<Genre> findByIsActiveTrueOrderByNameAsc();
    long countByIsActiveTrue();

    Optional<Genre> findByIdAndIsActiveTrue(Long id);

    Optional<Genre> findBySlugIgnoreCase(String slug);

    Optional<Genre> findBySlugIgnoreCaseAndIsActiveTrue(String slug);

    boolean existsByNameIgnoreCase(String name);

    boolean existsBySlugIgnoreCase(String slug);

    boolean existsByNameIgnoreCaseAndIdNot(String name, Long id);

    boolean existsBySlugIgnoreCaseAndIdNot(String slug, Long id);

    Page<Genre> findByIsActive(Boolean active, Pageable pageable);

    @Query("SELECT g FROM Genre g WHERE LOWER(g.name) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(g.slug) LIKE LOWER(CONCAT('%', :search, '%'))")
    Page<Genre> searchByKeyword(@Param("search") String search, Pageable pageable);

    @Query("SELECT g FROM Genre g WHERE g.isActive = :active AND (LOWER(g.name) LIKE LOWER(CONCAT('%', :search, '%')) OR LOWER(g.slug) LIKE LOWER(CONCAT('%', :search, '%')))")
    Page<Genre> searchByActiveAndKeyword(@Param("active") Boolean active, @Param("search") String search, Pageable pageable);

    default Page<Genre> searchForAdmin(String search, Boolean active, Pageable pageable) {
        boolean hasSearch = search != null && !search.trim().isBlank();
        String keyword = hasSearch ? search.trim().toLowerCase(Locale.ROOT) : null;
        if (hasSearch && active != null) {
            return searchByActiveAndKeyword(active, keyword, pageable);
        } else if (hasSearch) {
            return searchByKeyword(keyword, pageable);
        } else if (active != null) {
            return findByIsActive(active, pageable);
        } else {
            return findAll(pageable);
        }
    }
}
