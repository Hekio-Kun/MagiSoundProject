package group03.magisound.config;

import group03.magisound.authentication.dto.response.UserProfileSummary;
import group03.magisound.authentication.service.UserAccountPublicService;
import group03.magisound.catalog.dto.response.TrackResponse;
import group03.magisound.catalog.service.TrackCatalogService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class CreatorAccountsInitializerTest {

    @Autowired
    private UserAccountPublicService userAccountPublicService;

    @Autowired
    private TrackCatalogService trackCatalogService;

    @Test
    void testCreatorsSynchronizedSuccessfully() {
        // Verify Son Tung M-TP (ID 10)
        Optional<UserProfileSummary> sonTung = userAccountPublicService.findUserSummaryById(10L);
        assertTrue(sonTung.isPresent(), "Son Tung M-TP should exist in app_users");
        assertEquals("Sơn Tùng M-TP", sonTung.get().displayName());

        // Verify HIEUTHUHAI (ID 11)
        Optional<UserProfileSummary> hieu = userAccountPublicService.findUserSummaryById(11L);
        assertTrue(hieu.isPresent(), "HIEUTHUHAI should exist in app_users");
        assertEquals("HIEUTHUHAI", hieu.get().displayName());

        // Verify MCK (ID 12)
        Optional<UserProfileSummary> mck = userAccountPublicService.findUserSummaryById(12L);
        assertTrue(mck.isPresent(), "MCK should exist in app_users");
        assertEquals("MCK", mck.get().displayName());

        // Verify YOASOBI (ID 15)
        Optional<UserProfileSummary> yoasobi = userAccountPublicService.findUserSummaryById(15L);
        assertTrue(yoasobi.isPresent(), "YOASOBI should exist in app_users");
        assertEquals("YOASOBI", yoasobi.get().displayName());

        // Verify Yorushika (ID 16)
        Optional<UserProfileSummary> yorushika = userAccountPublicService.findUserSummaryById(16L);
        assertTrue(yorushika.isPresent(), "Yorushika should exist in app_users");
        assertEquals("Yorushika", yorushika.get().displayName());
    }

    @Test
    void testCatalogTracksHaveRealArtistNames() {
        var page = trackCatalogService.getPublishedTracks(null, null, "trending", PageRequest.of(0, 10));
        assertNotNull(page);
        assertFalse(page.getContent().isEmpty());

        for (TrackResponse track : page.getContent()) {
            assertNotNull(track.creator());
            assertNotEquals("Unknown Artist", track.creator().displayName(),
                    "Track '" + track.title() + "' (uploader " + track.creator().userId() + ") should NOT have 'Unknown Artist'");
            System.out.println("VERIFIED TRACK: " + track.title() + " by " + track.creator().displayName());
        }
    }
}
