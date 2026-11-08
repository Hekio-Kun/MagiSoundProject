package group03.magisound.lyrics.controller;

import group03.magisound.lyrics.dto.request.SaveOfficialLyricRequest;
import group03.magisound.lyrics.dto.request.UpdateOfficialLyricStatusRequest;
import group03.magisound.lyrics.dto.response.LyricDetailResponse;
import group03.magisound.lyrics.dto.response.StaffTrackLyricSummaryResponse;
import group03.magisound.lyrics.service.StaffOfficialLyricService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
@RequestMapping("/api/v1/staff/lyrics")
@RequiredArgsConstructor
@PreAuthorize("hasRole('STAFF') or hasRole('ADMIN')")
public class StaffOfficialLyricController {

    private final StaffOfficialLyricService staffOfficialLyricService;

    @GetMapping
    public ResponseEntity<Page<StaffTrackLyricSummaryResponse>> getTracksForLyricManagement(
            @RequestParam(required = false) String search,
            @PageableDefault(size = 15, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return ResponseEntity.ok(staffOfficialLyricService.getTracksForStaffLyricManagement(search, pageable));
    }

    @PostMapping
    public ResponseEntity<LyricDetailResponse> saveOrUpdateLyric(
            @Valid @RequestBody SaveOfficialLyricRequest request,
            Principal principal
    ) {
        return ResponseEntity.ok(staffOfficialLyricService.saveOrUpdateOfficialLyric(principal.getName(), request));
    }

    @PatchMapping("/{trackId}/status")
    public ResponseEntity<LyricDetailResponse> updateStatus(
            @PathVariable Long trackId,
            @Valid @RequestBody UpdateOfficialLyricStatusRequest request,
            Principal principal
    ) {
        return ResponseEntity.ok(staffOfficialLyricService.updateStatus(principal.getName(), trackId, request.status()));
    }

    @DeleteMapping("/{trackId}")
    public ResponseEntity<Void> deleteOfficialLyric(
            @PathVariable Long trackId,
            Principal principal
    ) {
        staffOfficialLyricService.deleteOfficialLyric(principal.getName(), trackId);
        return ResponseEntity.noContent().build();
    }
}
