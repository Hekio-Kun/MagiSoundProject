package group03.magisound.catalog.service;

import group03.magisound.catalog.dto.response.SearchCatalogResponse;
import group03.magisound.catalog.dto.response.TrackResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service tìm kiếm danh mục công khai theo đặc tả Sequence Diagram UC-07 (Search Public Catalog).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class SearchService {

    private final TrackCatalogService trackCatalogService;

    @Transactional(readOnly = true)
    public SearchCatalogResponse searchCatalog(String keyword, Long genreId, Pageable pageable) {
        String genreSlug = null;
        if (genreId != null) {
            genreSlug = String.valueOf(genreId);
        }

        Page<TrackResponse> page = trackCatalogService.getPublishedTracks(genreSlug, keyword, null, pageable);
        return new SearchCatalogResponse(page.getContent(), page.getTotalPages(), page.getTotalElements());
    }
}
