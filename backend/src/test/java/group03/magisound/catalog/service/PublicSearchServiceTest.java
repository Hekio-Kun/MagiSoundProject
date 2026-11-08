package group03.magisound.catalog.service;

import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.authentication.repository.UserProfileRepository;
import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.dto.response.UnifiedSearchResponse;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PublicSearchServiceTest {

    @Mock
    private TrackCatalogService trackCatalogService;

    @Mock
    private TrackRepository trackRepository;

    @Mock
    private UserProfileRepository userProfileRepository;

    @Mock
    private OfficialLyricRepository officialLyricRepository;

    @InjectMocks
    private PublicSearchService publicSearchService;

    @Test
    @DisplayName("search - Throws BadRequestOperationException when query is shorter than 2 characters (UC-07)")
    void search_QueryTooShort() {
        Pageable pageable = PageRequest.of(0, 10);
        assertThrows(BadRequestOperationException.class, () -> publicSearchService.search("a", "ALL", pageable));
        assertThrows(BadRequestOperationException.class, () -> publicSearchService.search("", "ALL", pageable));
        assertThrows(BadRequestOperationException.class, () -> publicSearchService.search(null, "ALL", pageable));
    }

    @Test
    @DisplayName("search - Executes unified search across songs and creators (UC-07)")
    void search_UnifiedAll_Success() {
        Pageable pageable = PageRequest.of(0, 10);

        TrackResponse mockTrack = new TrackResponse(
                1L, "Summer Breeze", "summer-breeze", "Desc",
                "/audio.mp3", "/cover.jpg", 200000, 100L, "PUBLISHED",
                "pop", "Pop", null,
                new TrackResponse.TrackCreatorSummary(10L, "Artist Name", null),
                null
        );

        when(trackCatalogService.getPublishedTracks(isNull(), eq("summer"), eq("latest"), any()))
                .thenReturn(new PageImpl<>(List.of(mockTrack)));

        UserProfile mockProfile = new UserProfile(null, "summer_artist", "Summer Artist");
        org.springframework.test.util.ReflectionTestUtils.setField(mockProfile, "userId", 10L);

        when(userProfileRepository.findAll()).thenReturn(List.of(mockProfile));
        when(trackRepository.countByUploaderUserId(10L)).thenReturn(3L);
        when(officialLyricRepository.searchPublishedLyrics(eq("summer"), any())).thenReturn(Page.empty());

        UnifiedSearchResponse response = publicSearchService.search("summer", "ALL", pageable);

        assertNotNull(response);
        assertEquals("summer", response.getQuery());
        assertEquals(1, response.getTracks().getContent().size());
        assertEquals("Summer Breeze", response.getTracks().getContent().get(0).title());
        assertEquals(1, response.getCreators().getContent().size());
        assertEquals("Summer Artist", response.getCreators().getContent().get(0).getDisplayName());
        assertNotNull(response.getTopResult());
    }
}
