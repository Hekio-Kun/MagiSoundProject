package group03.magisound.lyrics.service;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.Role;
import group03.magisound.authentication.repository.AppUserRepository;
import group03.magisound.catalog.entity.Track;
import group03.magisound.catalog.repository.TrackRepository;
import group03.magisound.exception.BadRequestOperationException;
import group03.magisound.lyrics.dto.request.SavePersonalLyricRequest;
import group03.magisound.lyrics.dto.response.LyricDetailResponse;
import group03.magisound.lyrics.dto.response.TrackLyricsBundleResponse;
import group03.magisound.lyrics.entity.OfficialLyric;
import group03.magisound.lyrics.entity.PersonalLyric;
import group03.magisound.lyrics.repository.OfficialLyricRepository;
import group03.magisound.lyrics.repository.PersonalLyricRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class LyricServiceTest {

    @Mock
    private OfficialLyricRepository officialLyricRepository;

    @Mock
    private PersonalLyricRepository personalLyricRepository;

    @Mock
    private TrackRepository trackRepository;

    @Mock
    private AppUserRepository userRepository;

    @InjectMocks
    private LyricService lyricService;

    private AppUser mockUser;
    private Track mockTrack;

    @BeforeEach
    void setUp() {
        mockUser = new AppUser(new Role("LISTENER", "Listener", "User"), "user@magisound.com", "pwd");
        ReflectionTestUtils.setField(mockUser, "id", 10L);

        mockTrack = Track.builder().id(100L).title("Song").build();
    }

    @Test
    @DisplayName("getTrackLyrics - Returns bundle with published official lyric and user personal lyric")
    void getTrackLyrics_Success() {
        when(trackRepository.findById(100L)).thenReturn(Optional.of(mockTrack));

        OfficialLyric official = OfficialLyric.builder()
                .id(1L)
                .track(mockTrack)
                .lyricContent("[00:01.00] Line 1")
                .status("PUBLISHED")
                .build();

        when(officialLyricRepository.findByTrackIdAndStatus(100L, "PUBLISHED")).thenReturn(Optional.of(official));
        when(userRepository.findByEmailIgnoreCase("user@magisound.com")).thenReturn(Optional.of(mockUser));

        PersonalLyric personal = PersonalLyric.builder()
                .id(2L)
                .user(mockUser)
                .track(mockTrack)
                .lyricType("CUSTOM")
                .lyricContent("[00:01.00] My custom line")
                .build();

        when(personalLyricRepository.findByUserIdAndTrackIdAndLyricType(10L, 100L, "CUSTOM")).thenReturn(Optional.of(personal));

        TrackLyricsBundleResponse bundle = lyricService.getTrackLyrics(100L, "user@magisound.com");

        assertNotNull(bundle);
        assertNotNull(bundle.officialLyric());
        assertEquals("[00:01.00] Line 1", bundle.officialLyric().lyricContent());
        assertNotNull(bundle.userPersonalLyric());
        assertEquals("[00:01.00] My custom line", bundle.userPersonalLyric().lyricContent());
    }

    @Test
    @DisplayName("savePersonalLyric - Successfully saves personal lyric")
    void savePersonalLyric_Success() {
        when(userRepository.findByEmailIgnoreCase("user@magisound.com")).thenReturn(Optional.of(mockUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(mockTrack));
        when(personalLyricRepository.findByUserIdAndTrackIdAndLyricType(10L, 100L, "CUSTOM")).thenReturn(Optional.empty());

        when(personalLyricRepository.save(any(PersonalLyric.class))).thenAnswer(inv -> {
            PersonalLyric p = inv.getArgument(0);
            ReflectionTestUtils.setField(p, "id", 50L);
            return p;
        });

        SavePersonalLyricRequest request = new SavePersonalLyricRequest("CUSTOM", "[00:01.00] Hello World");
        LyricDetailResponse response = lyricService.savePersonalLyric("user@magisound.com", 100L, request);

        assertNotNull(response);
        assertEquals(50L, response.id());
        assertEquals(100L, response.trackId());
        assertEquals("[00:01.00] Hello World", response.lyricContent());
        assertEquals("CUSTOM", response.lyricType());

        verify(personalLyricRepository, times(1)).save(any(PersonalLyric.class));
    }

    @Test
    @DisplayName("savePersonalLyric - Throws BadRequestOperationException when content is empty")
    void savePersonalLyric_EmptyContent() {
        when(userRepository.findByEmailIgnoreCase("user@magisound.com")).thenReturn(Optional.of(mockUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(mockTrack));

        SavePersonalLyricRequest request = new SavePersonalLyricRequest("CUSTOM", "   ");
        assertThrows(BadRequestOperationException.class, () ->
                lyricService.savePersonalLyric("user@magisound.com", 100L, request)
        );
        verify(personalLyricRepository, never()).save(any());
    }
}
