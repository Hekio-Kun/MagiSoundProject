package group03.magisound.authentication.repository;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {
    boolean existsByEmailIgnoreCase(String email);

    @EntityGraph(attributePaths = "role")
    Optional<AppUser> findByEmailIgnoreCase(String email);

    List<AppUser> findByEmailContainingIgnoreCase(String email);

    List<AppUser> findByRole_CodeIn(Collection<String> roleCodes);

    long countByDeletedAtIsNull();

    long countByStatusAndDeletedAtIsNull(UserStatus status);

    long countByCreatedAtBetweenAndDeletedAtIsNull(LocalDateTime start, LocalDateTime end);

    long countByRole_CodeIgnoreCase(String roleCode);

    List<AppUser> findTop5ByDeletedAtIsNullOrderByCreatedAtDesc();

    @Query("SELECT u FROM AppUser u WHERE u.createdAt >= :start AND u.deletedAt IS NULL")
    List<AppUser> findUsersCreatedSince(@Param("start") LocalDateTime start);

    @Query(value = "SELECT u FROM AppUser u JOIN FETCH u.role r " +
                   "WHERE r.code IN ('STAFF', 'ADMIN') " +
                   "AND (:search IS NULL OR LOWER(u.email) LIKE LOWER(CONCAT('%', :search, '%'))) " +
                   "AND (:status IS NULL OR u.status = :status)",
           countQuery = "SELECT count(u) FROM AppUser u JOIN u.role r " +
                        "WHERE r.code IN ('STAFF', 'ADMIN') " +
                        "AND (:search IS NULL OR LOWER(u.email) LIKE LOWER(CONCAT('%', :search, '%'))) " +
                        "AND (:status IS NULL OR u.status = :status)")
    Page<AppUser> findStaffUsers(
            @Param("search") String search,
            @Param("status") UserStatus status,
            Pageable pageable
    );
}
