package group03.magisound.catalog.service;

import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.dto.response.*;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.catalog.util.SearchNormalizeUtil;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.lyrics.entity.OfficialLyric;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class PublicSearchService {

    private final TrackCatalogService trackCatalogService;
    private final TrackRepository trackRepository;
    private final UserProfileRepository userProfileRepository;
    private final OfficialLyricRepository officialLyricRepository;

    /**
     * Tìm kiếm công khai hợp nhất qua bài hát đã xuất bản, nghệ sĩ sáng tác, và lời bài hát (UC-07).
     */
    @Transactional(readOnly = true)
    public UnifiedSearchResponse search(String query, String type, Pageable pageable) {
        if (query == null || query.trim().length() < 2) {
            throw new BadRequestOperationException("INVALID_KEYWORD_LENGTH", "Search keyword must be at least 2 characters long.");
        }

        String normalized = query.trim();
        String searchType = (type == null || type.isBlank()) ? "ALL" : type.trim().toUpperCase();

        Page<TrackResponse> tracks = Page.empty(pageable);
        Page<CreatorSearchResultResponse> creators = Page.empty(pageable);
        Page<LyricSearchResultResponse> lyrics = Page.empty(pageable);

        if ("ALL".equals(searchType) || "SONGS".equals(searchType)) {
            Pageable trackPageable = "ALL".equals(searchType) ? PageRequest.of(0, 10) : pageable;
            tracks = trackCatalogService.getPublishedTracks(null, normalized, "latest", trackPageable);
        }

        if ("ALL".equals(searchType) || "CREATORS".equals(searchType) || "ARTISTS".equals(searchType)) {
            Pageable creatorPageable = "ALL".equals(searchType) ? PageRequest.of(0, 6) : pageable;
            creators = searchCreators(normalized, creatorPageable);
        }

        if ("ALL".equals(searchType) || "LYRICS".equals(searchType)) {
            Pageable lyricPageable = "ALL".equals(searchType) ? PageRequest.of(0, 5) : pageable;
            lyrics = searchLyrics(normalized, lyricPageable);
        }

        TopResultResponse topResult = null;
        if ("ALL".equals(searchType)) {
            topResult = determineTopResult(
                    normalized,
                    tracks.getContent(),
                    creators.getContent()
            );
        }

        return UnifiedSearchResponse.builder()
                .query(normalized)
                .type(searchType)
                .topResult(topResult)
                .tracks(tracks)
                .creators(creators)
                .lyrics(lyrics)
                .build();
    }

    private Page<CreatorSearchResultResponse> searchCreators(String keyword, Pageable pageable) {
        String lower = keyword.toLowerCase();
        String unaccented = SearchNormalizeUtil.toUnaccented(lower);

        List<UserProfile> profiles = userProfileRepository.findAll();
        List<CreatorSearchResultResponse> matching = profiles.stream()
                .filter(p -> {
                    String dName = p.getDisplayName() != null ? p.getDisplayName().toLowerCase() : "";
                    String uName = p.getUsername() != null ? p.getUsername().toLowerCase() : "";
                    return dName.contains(lower)
                            || SearchNormalizeUtil.toUnaccented(dName).contains(unaccented)
                            || uName.contains(lower);
                })
                .map(p -> {
                    long trackCount = trackRepository.countByUploaderUserId(p.getUserId());
                    return CreatorSearchResultResponse.builder()
                            .userId(p.getUserId())
                            .username(p.getUsername())
                            .displayName(p.getDisplayName())
                            .avatarUrl(p.getAvatarUrl())
                            .bio(p.getBio())
                            .trackCount(trackCount)
                            .build();
                })
                .filter(c -> c.getTrackCount() > 0)
                .sorted((a, b) -> Long.compare(b.getTrackCount(), a.getTrackCount()))
                .toList();

        int start = (int) pageable.getOffset();
        int end = Math.min(start + pageable.getPageSize(), matching.size());
        List<CreatorSearchResultResponse> subList = (start <= end && start < matching.size())
                ? matching.subList(start, end)
                : Collections.emptyList();

        return new PageImpl<>(subList, pageable, matching.size());
    }

    private Page<LyricSearchResultResponse> searchLyrics(String keyword, Pageable pageable) {
        Page<OfficialLyric> lyricsPage;
        try {
            lyricsPage = officialLyricRepository.searchPublishedLyrics(keyword, pageable);
        } catch (Exception ex) {
            log.warn("Database fulltext search failed for lyrics: {}. Using empty results.", ex.getMessage());
            lyricsPage = Page.empty(pageable);
        }

        List<LyricSearchResultResponse> responses = lyricsPage.getContent().stream()
                .map(lyric -> {
                    TrackResponse trackResponse = trackCatalogService.mapToTrackResponse(lyric.getTrack());
                    String snippet = extractLyricSnippet(lyric.getLyricContent(), keyword);
                    return LyricSearchResultResponse.builder()
                            .officialLyricId(lyric.getId())
                            .track(trackResponse)
                            .lyricSnippet(snippet)
                            .build();
                })
                .toList();

        return new PageImpl<>(responses, pageable, lyricsPage.getTotalElements());
    }

    public String extractLyricSnippet(String lyricContent, String keyword) {
        if (lyricContent == null || keyword == null || lyricContent.isBlank() || keyword.isBlank()) {
            return "";
        }
        String[] lines = lyricContent.split("\\r?\\n");
        String lowerKeyword = keyword.toLowerCase();
        String unaccentedKeyword = SearchNormalizeUtil.toUnaccented(lowerKeyword);
        List<String> matchingLines = new ArrayList<>();

        for (String rawLine : lines) {
            String cleanLine = rawLine.replaceAll("\\[\\d{1,2}:\\d{2}(?:\\.\\d{1,3})?\\]", "").trim();
            if (cleanLine.toLowerCase().contains(lowerKeyword) || SearchNormalizeUtil.toUnaccented(cleanLine).contains(unaccentedKeyword)) {
                matchingLines.add(cleanLine);
                if (matchingLines.size() >= 2) break;
            }
        }

        return String.join(" ... ", matchingLines);
    }

    private TopResultResponse determineTopResult(
            String keyword,
            List<TrackResponse> tracks,
            List<CreatorSearchResultResponse> creators
    ) {
        String lower = keyword.toLowerCase();
        String unaccented = SearchNormalizeUtil.toUnaccented(lower);

        for (TrackResponse track : tracks) {
            if (track.title() != null && (track.title().equalsIgnoreCase(lower) || SearchNormalizeUtil.toUnaccented(track.title()).equalsIgnoreCase(unaccented))) {
                return TopResultResponse.builder().type("SONG").track(track).build();
            }
        }

        for (CreatorSearchResultResponse creator : creators) {
            if ((creator.getDisplayName() != null && (creator.getDisplayName().equalsIgnoreCase(lower) || SearchNormalizeUtil.toUnaccented(creator.getDisplayName()).equalsIgnoreCase(unaccented)))
                    || (creator.getUsername() != null && creator.getUsername().equalsIgnoreCase(lower))) {
                return TopResultResponse.builder().type("CREATOR").creator(creator).build();
            }
        }

        if (!tracks.isEmpty()) {
            return TopResultResponse.builder().type("SONG").track(tracks.get(0)).build();
        }
        if (!creators.isEmpty()) {
            return TopResultResponse.builder().type("CREATOR").creator(creators.get(0)).build();
        }

        return null;
    }
}
