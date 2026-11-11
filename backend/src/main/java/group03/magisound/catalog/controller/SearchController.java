package group03.magisound.catalog.controller;

import group03.magisound.catalog.dto.response.SearchCatalogResponse;
import group03.magisound.catalog.service.SearchService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller tìm kiếm danh mục công khai theo đặc tả Sequence Diagram UC-07 (Search Public Catalog).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/catalog/search")
@RequiredArgsConstructor
public class SearchController {

    private final SearchService searchService;

    @GetMapping
    public ResponseEntity<SearchCatalogResponse> searchCatalog(
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "genreId", required = false) Long genreId,
            @PageableDefault(size = 10) Pageable pageable
    ) {
        log.info("Catalog search requested: keyword='{}', genreId={}, page={}", keyword, genreId, pageable.getPageNumber());
        SearchCatalogResponse response = searchService.searchCatalog(keyword, genreId, pageable);
        return ResponseEntity.ok(response);
    }
}
