package group03.magisound.catalog.controller;

import group03.magisound.catalog.dto.response.UnifiedSearchResponse;
import group03.magisound.catalog.service.PublicSearchService;
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
 * REST controller cho tìm kiếm công khai danh mục MagiSound (UC-07: Search Public Catalog).
 */
@Slf4j
@RestController
@RequestMapping("/api/v1/search")
@RequiredArgsConstructor
public class PublicSearchController {

    private final PublicSearchService publicSearchService;

    /**
     * Thực thi tìm kiếm hợp nhất công khai trên catalog.
     *
     * @param query    Từ khóa tìm kiếm (tối thiểu 2 ký tự)
     * @param type     Loại đối tượng ('ALL', 'SONGS', 'CREATORS', 'ARTISTS', 'LYRICS')
     * @param pageable Phân trang kết quả
     * @return UnifiedSearchResponse chứa kết quả bài hát, nghệ sĩ, lời bài hát và kết quả hàng đầu
     */
    @GetMapping
    public ResponseEntity<UnifiedSearchResponse> search(
            @RequestParam(name = "q") String query,
            @RequestParam(name = "type", required = false, defaultValue = "ALL") String type,
            @PageableDefault(size = 20) Pageable pageable
    ) {
        log.info("Public search requested: query='{}', type='{}', page={}", query, type, pageable.getPageNumber());
        return ResponseEntity.ok(publicSearchService.search(query, type, pageable));
    }
}
