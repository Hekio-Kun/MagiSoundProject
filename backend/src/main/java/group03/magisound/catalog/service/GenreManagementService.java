package group03.magisound.catalog.service;

import group03.magisound.catalog.dto.request.CreateGenreRequest;
import group03.magisound.catalog.dto.request.UpdateGenreRequest;
import group03.magisound.catalog.dto.response.AdminGenrePageResponse;
import group03.magisound.catalog.dto.response.AdminGenreResponse;
import group03.magisound.catalog.dto.response.GenreBundleResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Service quản lý thể loại âm nhạc theo đặc tả Sequence Diagram UC-21 (21.1 -> 21.6).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class GenreManagementService {

    private final GenreService genreService;

    @Transactional
    public AdminGenreResponse createGenre(CreateGenreRequest request, String adminEmail) {
        return genreService.createGenre(request, adminEmail);
    }

    @Transactional(readOnly = true)
    public GenreBundleResponse getGenres(String search, Boolean active, Pageable pageable) {
        AdminGenrePageResponse page = genreService.getGenres(search, active, pageable);
        return new GenreBundleResponse(page.content(), page.totalElements(), page.totalPages(), page.number());
    }

    @Transactional(readOnly = true)
    public AdminGenreResponse getGenre(Long id) {
        return genreService.getGenre(id);
    }

    @Transactional
    public AdminGenreResponse updateGenre(Long id, UpdateGenreRequest request) {
        return genreService.updateGenre(id, request);
    }

    @Transactional
    public AdminGenreResponse deactivateGenre(Long id) {
        return genreService.updateActiveState(id, false);
    }

    @Transactional(readOnly = true)
    public GenreBundleResponse searchGenres(String keyword) {
        AdminGenrePageResponse page = genreService.getGenres(keyword, null, Pageable.unpaged());
        List<AdminGenreResponse> list = page != null && page.content() != null ? page.content() : List.of();
        return new GenreBundleResponse(list);
    }

    @Transactional(readOnly = true)
    public GenreBundleResponse filterGenresByStatus(String status) {
        Boolean active = null;
        if ("ACTIVE".equalsIgnoreCase(status) || "true".equalsIgnoreCase(status)) {
            active = true;
        } else if ("INACTIVE".equalsIgnoreCase(status) || "false".equalsIgnoreCase(status)) {
            active = false;
        }
        AdminGenrePageResponse page = genreService.getGenres(null, active, Pageable.unpaged());
        List<AdminGenreResponse> list = page != null && page.content() != null ? page.content() : List.of();
        return new GenreBundleResponse(list);
    }

    @Transactional
    public void deleteGenre(Long id) {
        genreService.deleteGenre(id);
    }
}
