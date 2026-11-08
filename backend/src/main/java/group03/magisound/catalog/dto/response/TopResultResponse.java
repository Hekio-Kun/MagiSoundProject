package group03.magisound.catalog.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TopResultResponse {
    private String type; // "SONG", "CREATOR"
    private TrackResponse track;
    private CreatorSearchResultResponse creator;
}
