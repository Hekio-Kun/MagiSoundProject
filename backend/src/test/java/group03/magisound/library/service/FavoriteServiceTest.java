package group03.magisound.library.service;

import group03.magisound.authentication.dto.response.UserProfileSummary;
import group03.magisound.authentication.service.UserAccountPublicService;
import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.entity.TrackPublicationStatus;
import group03.magisound.catalog.service.TrackCatalogPublicService;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.exception.ResourceNotFoundException;
import group03.magisound.library.entity.Favorite;
import group03.magisound.library.entity.FavoriteId;
import group03.magisound.library.repository.FavoriteRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatNoException;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class FavoriteServiceTest {

    @Mock
    private FavoriteRepository favoriteRepository;

    @Mock
    private TrackCatalogPublicService trackCatalogPublicService;

    @Mock
    private UserAccountPublicService userAccountPublicService;

    @InjectMocks
    private FavoriteService favoriteService;

    private static final String USER_EMAIL = "listener@magisound.com";
    private static final Long USER_ID = 10L;
    private static final Long TRACK_ID = 100L;

    private Track publishedTrack;

    @BeforeEach
    void setUp() {
        Genre genre = Genre.builder()
                .id(1L)
                .name("Pop")
                .slug("pop")
                .isActive(true)
                .build();

        publishedTrack = Track.builder()
                .id(TRACK_ID)
                .title("Ocean Waves")
                .slug("ocean-waves")
                .uploaderUserId(20L)
                .genre(genre)
                .audioPublicId("audio/ocean_waves")
                .audioUrl("/api/v1/stream/audio/ocean_waves")
                .publicationStatus(TrackPublicationStatus.PUBLISHED)
                .createdAt(LocalDateTime.now(ZoneOffset.UTC))
                .build();
    }

    @Test
    @DisplayName("Thêm bài hát vào danh sách yêu thích thành công khi bài hát đã PUBLISHED và chưa được like")
    void addFavorite_Success() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);
        when(trackCatalogPublicService.validatePublishedTrack(TRACK_ID)).thenReturn(publishedTrack);
        when(favoriteRepository.existsById(new FavoriteId(USER_ID, TRACK_ID))).thenReturn(false);

        assertThatNoException().isThrownBy(() -> favoriteService.addFavorite(USER_EMAIL, TRACK_ID));

        verify(favoriteRepository, times(1)).save(any(Favorite.class));
    }

    @Test
    @DisplayName("Ném BadRequestOperationException khi trackId là null hoặc nhỏ hơn hoặc bằng 0")
    void addFavorite_InvalidTrackId() {
        assertThatThrownBy(() -> favoriteService.addFavorite(USER_EMAIL, null))
                .isInstanceOf(BadRequestOperationException.class)
                .hasMessageContaining("Track ID must be a valid positive number.");

        assertThatThrownBy(() -> favoriteService.addFavorite(USER_EMAIL, 0L))
                .isInstanceOf(BadRequestOperationException.class)
                .hasMessageContaining("Track ID must be a valid positive number.");

        assertThatThrownBy(() -> favoriteService.addFavorite(USER_EMAIL, -5L))
                .isInstanceOf(BadRequestOperationException.class)
                .hasMessageContaining("Track ID must be a valid positive number.");

        verifyNoInteractions(favoriteRepository);
    }

    @Test
    @DisplayName("Ném ResourceNotFoundException khi bài hát không tồn tại")
    void addFavorite_TrackNotFound() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);
        when(trackCatalogPublicService.validatePublishedTrack(TRACK_ID))
                .thenThrow(new ResourceNotFoundException("TRACK_NOT_FOUND", "Track not found with ID: " + TRACK_ID));

        assertThatThrownBy(() -> favoriteService.addFavorite(USER_EMAIL, TRACK_ID))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Track not found with ID");

        verify(favoriteRepository, never()).save(any(Favorite.class));
    }

    @Test
    @DisplayName("Lấy danh sách bài hát yêu thích thành công kèm thông tin nghệ sĩ")
    void getFavoriteTracks_Success() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);

        Favorite favorite = Favorite.builder()
                .id(new FavoriteId(USER_ID, TRACK_ID))
                .track(publishedTrack)
                .createdAt(LocalDateTime.now(ZoneOffset.UTC))
                .build();

        when(favoriteRepository.findFavoritesByUserIdAndPublicationStatus(USER_ID, TrackPublicationStatus.PUBLISHED))
                .thenReturn(List.of(favorite));

        UserProfileSummary creatorProfile = new UserProfileSummary(
                20L, "artist@magisound.com", "Ocean Artist", "https://cdn.magisound.com/avatar.jpg", "LISTENER"
        );

        when(userAccountPublicService.getUserSummariesByIds(Set.of(20L)))
                .thenReturn(Map.of(20L, creatorProfile));

        List<TrackResponse> results = favoriteService.getFavoriteTracks(USER_EMAIL);

        assertThat(results).hasSize(1);
        TrackResponse response = results.get(0);
        assertThat(response.id()).isEqualTo(TRACK_ID);
        assertThat(response.title()).isEqualTo("Ocean Waves");
        assertThat(response.publicationStatus()).isEqualTo("PUBLISHED");
        assertThat(response.creator().displayName()).isEqualTo("Ocean Artist");
    }

    @Test
    @DisplayName("Trả về danh sách rỗng khi người dùng chưa like bài hát nào")
    void getFavoriteTracks_Empty() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);
        when(favoriteRepository.findFavoritesByUserIdAndPublicationStatus(USER_ID, TrackPublicationStatus.PUBLISHED))
                .thenReturn(Collections.emptyList());

        List<TrackResponse> results = favoriteService.getFavoriteTracks(USER_EMAIL);

        assertThat(results).isEmpty();
        verify(userAccountPublicService, never()).getUserSummariesByIds(any());
    }

    @Test
    @DisplayName("Xóa bài hát khỏi danh sách yêu thích thành công")
    void removeFavorite_Success() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);
        when(favoriteRepository.existsById(new FavoriteId(USER_ID, TRACK_ID))).thenReturn(true);

        assertThatNoException().isThrownBy(() -> favoriteService.removeFavorite(USER_EMAIL, TRACK_ID));

        verify(favoriteRepository, times(1)).deleteById(new FavoriteId(USER_ID, TRACK_ID));
    }

    @Test
    @DisplayName("Xử lý idempotent khi bài hát không còn trong favorites thì không ném lỗi")
    void removeFavorite_AlreadyAbsent_Idempotent() {
        when(userAccountPublicService.getUserIdByEmail(USER_EMAIL)).thenReturn(USER_ID);
        when(favoriteRepository.existsById(new FavoriteId(USER_ID, TRACK_ID))).thenReturn(false);

        assertThatNoException().isThrownBy(() -> favoriteService.removeFavorite(USER_EMAIL, TRACK_ID));

        verify(favoriteRepository, never()).deleteById(any(FavoriteId.class));
    }
}
