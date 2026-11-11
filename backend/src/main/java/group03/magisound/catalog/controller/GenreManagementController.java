package group03.magisound.catalog.controller;

import group03.magisound.catalog.dto.request.CreateGenreRequest;
import group03.magisound.catalog.dto.request.UpdateGenreRequest;
import group03.magisound.catalog.dto.request.UpdateGenreStatusRequest;
import group03.magisound.catalog.dto.response.AdminGenreResponse;
import group03.magisound.catalog.dto.response.GenreBundleResponse;
import group03.magisound.catalog.service.GenreManagementService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

/**
 * Controller quản trị thể loại âm nhạc theo đặc tả Sequence Diagram UC-21 (21.1 -> 21.6).
 */
@RestController
@RequestMapping("/api/v1/admin/genres")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class GenreManagementController {

    private final GenreManagementService genreManagementService;

    /**
     * Lấy danh sách thể loại có tìm kiếm, lọc theo trạng thái và phân trang (UC-21.2 View Genres).
     */
    @GetMapping
    public ResponseEntity<GenreBundleResponse> getGenres(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Boolean active,
            @PageableDefault(sort = "name", direction = Sort.Direction.ASC) Pageable pageable) {
        return ResponseEntity.ok(genreManagementService.getGenres(search, active, pageable));
    }

    /**
     * Lấy thông tin chi tiết một thể loại theo ID.
     */
    @GetMapping("/{id}")
    public ResponseEntity<AdminGenreResponse> getGenre(@PathVariable Long id) {
        return ResponseEntity.ok(genreManagementService.getGenre(id));
    }

    /**
     * Tạo mới một thể loại âm nhạc (UC-21.1 Create A Genre).
     */
    @PostMapping
    public ResponseEntity<AdminGenreResponse> createGenre(
            @Valid @RequestBody CreateGenreRequest request,
            Principal principal) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(genreManagementService.createGenre(request, principal != null ? principal.getName() : "system"));
    }

    /**
     * Cập nhật thông tin thể loại âm nhạc (UC-21.3 Update A Genre).
     */
    @PutMapping("/{id}")
    public ResponseEntity<AdminGenreResponse> updateGenre(
            @PathVariable Long id,
            @Valid @RequestBody UpdateGenreRequest request) {
        return ResponseEntity.ok(genreManagementService.updateGenre(id, request));
    }

    /**
     * Vô hiệu hóa một thể loại theo UC-21.4 (Deactivate Genre).
     */
    @PutMapping("/{id}/deactivate")
    public ResponseEntity<AdminGenreResponse> deactivateGenre(@PathVariable Long id) {
        return ResponseEntity.ok(genreManagementService.deactivateGenre(id));
    }

    /**
     * Thay đổi trạng thái kích hoạt hoặc vô hiệu hóa của một thể loại.
     */
    @PatchMapping("/{id}/status")
    public ResponseEntity<AdminGenreResponse> updateGenreStatus(
            @PathVariable Long id,
            @Valid @RequestBody UpdateGenreStatusRequest request) {
        if (Boolean.FALSE.equals(request.active())) {
            return ResponseEntity.ok(genreManagementService.deactivateGenre(id));
        }
        return ResponseEntity.ok(genreManagementService.getGenre(id));
    }

    /**
     * Tìm kiếm thể loại theo từ khóa theo UC-21.5 (Search Genre).
     */
    @GetMapping("/search")
    public ResponseEntity<GenreBundleResponse> searchGenres(@RequestParam(name = "keyword", required = false) String keyword) {
        return ResponseEntity.ok(genreManagementService.searchGenres(keyword));
    }

    /**
     * Lọc thể loại theo trạng thái theo UC-21.6 (Filter Genre).
     */
    @GetMapping("/filter")
    public ResponseEntity<GenreBundleResponse> filterGenres(@RequestParam(name = "status", required = false) String status) {
        return ResponseEntity.ok(genreManagementService.filterGenresByStatus(status));
    }

    /**
     * Xóa một thể loại chưa được liên kết với bất kỳ bài hát nào.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteGenre(@PathVariable Long id) {
        genreManagementService.deleteGenre(id);
        return ResponseEntity.noContent().build();
    }
}
