import os

def replace_in_file(path, old, new):
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    if old not in content:
        print(f"ERROR: Target not found in {path}")
        return False
    content = content.replace(old, new)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Successfully updated {path}")
    return True

# 1. TrackRepository.java
tr_path = "backend/src/main/java/group03/magisound/catalog/repository/TrackRepository.java"
with open(tr_path, "r", encoding="utf-8") as f:
    tr = f.read()

tr_targets = [
    "    boolean existsByAlbum_Id(Long albumId);\n",
    "    List<Track> findByAlbum_IdOrderByTrackNumberAsc(Long albumId);\n",
    "    long countByAlbum_Id(Long albumId);\n",
    "    boolean existsByAlbum_IdAndPublicationStatus(Long albumId, TrackPublicationStatus publicationStatus);\n",
    "    List<Track> findByUploaderUserIdAndAlbumIsNullOrderByCreatedAtDesc(Long uploaderUserId);\n",
    """    @Modifying
    @Query("UPDATE Track t SET t.album = null, t.trackNumber = null, t.updatedAt = CURRENT_TIMESTAMP WHERE t.album.id = :albumId AND t.uploaderUserId = :userId")
    void unlinkAlbumFromTracks(@Param("albumId") Long albumId, @Param("userId") Long userId);
"""
]
for t in tr_targets:
    if t in tr:
        tr = tr.replace(t, "")
with open(tr_path, "w", encoding="utf-8") as f:
    f.write(tr)
print("Updated TrackRepository.java")

# 2. TrackCatalogService.java
tcs_path = "backend/src/main/java/group03/magisound/catalog/service/TrackCatalogService.java"
with open(tcs_path, "r", encoding="utf-8") as f:
    tcs = f.read()

tcs = tcs.replace(
    "                            || (t.getAlbum() != null && t.getAlbum().getTitle() != null && t.getAlbum().getTitle().toLowerCase().contains(lowerSearch))\n",
    ""
)
old_map_album = """        TrackResponse.TrackAlbumSummary albumSummary = null;
        if (track.getAlbum() != null) {
            albumSummary = new TrackResponse.TrackAlbumSummary(
                    track.getAlbum().getId(),
                    track.getAlbum().getTitle()
            );
        }"""
tcs = tcs.replace(old_map_album, "        TrackResponse.TrackAlbumSummary albumSummary = null;")
with open(tcs_path, "w", encoding="utf-8") as f:
    f.write(tcs)
print("Updated TrackCatalogService.java")

# 3. PlaylistService.java
ps_path = "backend/src/main/java/group03/magisound/library/service/PlaylistService.java"
with open(ps_path, "r", encoding="utf-8") as f:
    ps = f.read()
ps = ps.replace(old_map_album, "        TrackResponse.TrackAlbumSummary albumSummary = null;")
with open(ps_path, "w", encoding="utf-8") as f:
    f.write(ps)
print("Updated PlaylistService.java")

# 4. TrackDetailResponse.java
tdr_path = "backend/src/main/java/group03/magisound/moderation/dto/response/TrackDetailResponse.java"
with open(tdr_path, "r", encoding="utf-8") as f:
    tdr = f.read()
tdr = tdr.replace(" * @param album                 Thông tin tóm tắt album\n", "")
tdr = tdr.replace("        AlbumSummaryResponse album,\n", "")
with open(tdr_path, "w", encoding="utf-8") as f:
    f.write(tdr)
print("Updated TrackDetailResponse.java")

# 5. TrackSubmissionMapper.java
tsm_path = "backend/src/main/java/group03/magisound/moderation/mapper/TrackSubmissionMapper.java"
with open(tsm_path, "r", encoding="utf-8") as f:
    tsm = f.read()

tsm = tsm.replace("import group03.magisound.catalog.entity.Album;\n", "")
tsm = tsm.replace(
    "String albumTitle = (track != null && track.getAlbum() != null) ? track.getAlbum().getTitle() : null;",
    "String albumTitle = null;"
)
old_tsm_ret = """        GenreSummaryResponse genreSummary = toGenreSummaryResponse(track.getGenre());
        AlbumSummaryResponse albumSummary = toAlbumSummaryResponse(track.getAlbum());

        return new TrackDetailResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getTrackNumber(),
                track.getPublicationStatus() != null ? track.getPublicationStatus().name() : null,
                track.getAudioUrl(),
                track.getAudioFormat(),
                track.getDurationMs(),
                track.getCoverUrl(),
                track.getPlayCountCache(),
                track.getApprovedAt(),
                track.getLatestRejectionReason(),
                track.getCreatedAt(),
                genreSummary,
                albumSummary,
                lyrics
        );"""

new_tsm_ret = """        GenreSummaryResponse genreSummary = toGenreSummaryResponse(track.getGenre());

        return new TrackDetailResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getTrackNumber(),
                track.getPublicationStatus() != null ? track.getPublicationStatus().name() : null,
                track.getAudioUrl(),
                track.getAudioFormat(),
                track.getDurationMs(),
                track.getCoverUrl(),
                track.getPlayCountCache(),
                track.getApprovedAt(),
                track.getLatestRejectionReason(),
                track.getCreatedAt(),
                genreSummary,
                lyrics
        );"""
tsm = tsm.replace(old_tsm_ret, new_tsm_ret)

album_sum_method = """    /**
     * Ánh xạ thực thể album (Album) sang DTO tóm tắt AlbumSummaryResponse.
     *
     * @param album Thực thể Album
     * @return DTO AlbumSummaryResponse
     */
    public AlbumSummaryResponse toAlbumSummaryResponse(Album album) {
        if (album == null) {
            return null;
        }
        return new AlbumSummaryResponse(album.getId(), album.getTitle(), album.getSlug(), album.getStatus());
    }
"""
tsm = tsm.replace(album_sum_method, "")
with open(tsm_path, "w", encoding="utf-8") as f:
    f.write(tsm)
print("Updated TrackSubmissionMapper.java")

# 6. ModerationService.java
ms_path = "backend/src/main/java/group03/magisound/moderation/service/ModerationService.java"
with open(ms_path, "r", encoding="utf-8") as f:
    ms = f.read()

ms = ms.replace("import group03.magisound.catalog.entity.Album;\n", "")
ms = ms.replace("import group03.magisound.catalog.repository.AlbumRepository;\n", "")
ms = ms.replace("    private final AlbumRepository albumRepository;\n", "")
mod_br18 = """        // 6. Quy tắc nghiệp vụ BR-18: Tự động kích hoạt xuất bản Album nếu Album đang ở trạng thái DRAFT
        Album album = track.getAlbum();
        if (album != null && "DRAFT".equalsIgnoreCase(album.getStatus())) {
            album.setStatus("PUBLISHED");
            album.setPublishedAt(nowUtc);
            albumRepository.save(album);
        }
        trackRepository.save(track);"""
ms = ms.replace(mod_br18, "        trackRepository.save(track);")
with open(ms_path, "w", encoding="utf-8") as f:
    f.write(ms)
print("Updated ModerationService.java")

# 7. StudioTrackController.java
stc_path = "backend/src/main/java/group03/magisound/studio/controller/StudioTrackController.java"
with open(stc_path, "r", encoding="utf-8") as f:
    stc = f.read()
stc = stc.replace("import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")
with open(stc_path, "w", encoding="utf-8") as f:
    f.write(stc)
print("Updated StudioTrackController.java")

# 8. StudioTrackMapper.java
stm_path = "backend/src/main/java/group03/magisound/studio/mapper/StudioTrackMapper.java"
with open(stm_path, "r", encoding="utf-8") as f:
    stm = f.read()

stm = stm.replace("import group03.magisound.catalog.entity.Album;\n", "")
stm = stm.replace("import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")

old_to_studio_resp = """    public StudioTrackResponse toStudioTrackResponse(Track track, Genre genre, Album album, TrackSubmission latestSubmission) {
        String genreName = genre != null ? genre.getName() : (track.getGenre() != null ? track.getGenre().getName() : "Unknown");
        String genreSlug = genre != null ? genre.getSlug() : (track.getGenre() != null ? track.getGenre().getSlug() : "");
        String albumTitle = album != null ? album.getTitle() : (track.getAlbum() != null ? track.getAlbum().getTitle() : null);

        String rejectionReason = track.getLatestRejectionReason();
        String reviewerNote = null;
        String submitterNote = null;
        java.time.Instant submittedAt = null;
        java.time.Instant reviewedAt = null;

        if (latestSubmission != null) {
            if (rejectionReason == null || rejectionReason.isBlank()) {
                rejectionReason = latestSubmission.getRejectionReason();
            }
            reviewerNote = latestSubmission.getReviewerNote();
            submitterNote = latestSubmission.getSubmitterNote();
            submittedAt = latestSubmission.getSubmittedAt();
            reviewedAt = latestSubmission.getReviewedAt();
        }

        return new StudioTrackResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getGenreId(),
                genreName,
                genreSlug,
                track.getAlbumId(),
                albumTitle,
                track.getTrackNumber(),
                track.getPublicationStatus().name(),
                track.getAudioUrl(),
                track.getAudioFormat(),
                track.getDurationMs(),
                track.getCoverUrl(),
                track.getPlayCountCache(),
                rejectionReason,
                reviewerNote,
                submitterNote,
                submittedAt,
                reviewedAt,
                track.getCreatedAt() != null ? track.getCreatedAt().toInstant(java.time.ZoneOffset.UTC) : null,
                track.getUpdatedAt() != null ? track.getUpdatedAt().toInstant(java.time.ZoneOffset.UTC) : null,
                track.getLyrics()
        );
    }"""

new_to_studio_resp = """    public StudioTrackResponse toStudioTrackResponse(Track track, Genre genre, TrackSubmission latestSubmission) {
        String genreName = genre != null ? genre.getName() : (track.getGenre() != null ? track.getGenre().getName() : "Unknown");
        String genreSlug = genre != null ? genre.getSlug() : (track.getGenre() != null ? track.getGenre().getSlug() : "");

        String rejectionReason = track.getLatestRejectionReason();
        String reviewerNote = null;
        String submitterNote = null;
        java.time.Instant submittedAt = null;
        java.time.Instant reviewedAt = null;

        if (latestSubmission != null) {
            if (rejectionReason == null || rejectionReason.isBlank()) {
                rejectionReason = latestSubmission.getRejectionReason();
            }
            reviewerNote = latestSubmission.getReviewerNote();
            submitterNote = latestSubmission.getSubmitterNote();
            submittedAt = latestSubmission.getSubmittedAt();
            reviewedAt = latestSubmission.getReviewedAt();
        }

        return new StudioTrackResponse(
                track.getId(),
                track.getTitle(),
                track.getSlug(),
                track.getDescription(),
                track.getGenreId(),
                genreName,
                genreSlug,
                null,
                null,
                track.getTrackNumber(),
                track.getPublicationStatus().name(),
                track.getAudioUrl(),
                track.getAudioFormat(),
                track.getDurationMs(),
                track.getCoverUrl(),
                track.getPlayCountCache(),
                rejectionReason,
                reviewerNote,
                submitterNote,
                submittedAt,
                reviewedAt,
                track.getCreatedAt() != null ? track.getCreatedAt().toInstant(java.time.ZoneOffset.UTC) : null,
                track.getUpdatedAt() != null ? track.getUpdatedAt().toInstant(java.time.ZoneOffset.UTC) : null,
                track.getLyrics()
        );
    }"""
stm = stm.replace(old_to_studio_resp, new_to_studio_resp)

old_album_opt = """    public AlbumOptionResponse toAlbumOption(Album album) {
        return new AlbumOptionResponse(
                album.getId(),
                album.getTitle(),
                album.getSlug()
        );
    }
"""
stm = stm.replace(old_album_opt, "")
with open(stm_path, "w", encoding="utf-8") as f:
    f.write(stm)
print("Updated StudioTrackMapper.java")

# 9. StudioTrackService.java
sts_path = "backend/src/main/java/group03/magisound/studio/service/StudioTrackService.java"
with open(sts_path, "r", encoding="utf-8") as f:
    sts = f.read()

sts = sts.replace("import group03.magisound.catalog.entity.Album;\n", "")
sts = sts.replace("import group03.magisound.catalog.repository.AlbumRepository;\n", "")
sts = sts.replace("import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")
sts = sts.replace("    private final AlbumRepository albumRepository;\n", "")

old_get_my_tracks = """        return tracks.stream().map(track -> {
            Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
            Album album = track.getAlbumId() != null ? albumRepository.findById(track.getAlbumId()).orElse(null) : null;
            TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);
            return studioTrackMapper.toStudioTrackResponse(track, genre, album, submission);
        }).toList();"""
new_get_my_tracks = """        return tracks.stream().map(track -> {
            Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
            TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);
            return studioTrackMapper.toStudioTrackResponse(track, genre, submission);
        }).toList();"""
sts = sts.replace(old_get_my_tracks, new_get_my_tracks)

old_get_track_by_id = """        Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
        Album album = track.getAlbumId() != null ? albumRepository.findById(track.getAlbumId()).orElse(null) : null;
        TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, album, submission);"""
new_get_track_by_id = """        Genre genre = track.getGenreId() != null ? genreRepository.findById(track.getGenreId()).orElse(null) : null;
        TrackSubmission submission = trackSubmissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(track.getId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, submission);"""
sts = sts.replace(old_get_track_by_id, new_get_track_by_id)

old_create_album_lookup = """        Album album = null;
        if (request.albumId() != null) {
            album = albumRepository.findByIdAndCreatedByUserId(request.albumId(), user.getId())
                    .orElseThrow(() -> new BadRequestOperationException("Selected album is invalid or unauthorized."));
        }
"""
sts = sts.replace(old_create_album_lookup, "")
sts = sts.replace("                .album(album)\n", "")
sts = sts.replace(
    "return studioTrackMapper.toStudioTrackResponse(savedTrack, genre, album, null);",
    "return studioTrackMapper.toStudioTrackResponse(savedTrack, genre, null);"
)

old_update_album_lookup = """        Album oldAlbum = track.getAlbum();
        Album album = null;
        if (request.albumId() != null) {
            album = albumRepository.findByIdAndCreatedByUserId(request.albumId(), user.getId())
                    .orElseThrow(() -> new BadRequestOperationException("Selected album is invalid or unauthorized."));
        }
"""
sts = sts.replace(old_update_album_lookup, "")
sts = sts.replace("        track.setAlbum(album);\n", "")

old_update_pub_check = """        if (track.getPublicationStatus() == TrackPublicationStatus.PUBLISHED) {
            if (oldAlbum != null && (album == null || !oldAlbum.getId().equals(album.getId()))) {
                boolean oldAlbumHasPublished = trackRepository.existsByAlbum_IdAndPublicationStatus(
                        oldAlbum.getId(), TrackPublicationStatus.PUBLISHED
                );
                if (!oldAlbumHasPublished) {
                    oldAlbum.setStatus("DRAFT");
                    albumRepository.save(oldAlbum);
                }
            }
            if (album != null && !"PUBLISHED".equalsIgnoreCase(album.getStatus())) {
                album.setStatus("PUBLISHED");
                if (album.getPublishedAt() == null) {
                    album.setPublishedAt(LocalDateTime.now(ZoneOffset.UTC));
                }
                albumRepository.save(album);
            }
        }
"""
sts = sts.replace(old_update_pub_check, "")
sts = sts.replace(
    "return studioTrackMapper.toStudioTrackResponse(updatedTrack, genre, album, submission);",
    "return studioTrackMapper.toStudioTrackResponse(updatedTrack, genre, submission);"
)

sts = sts.replace("        Album album = track.getAlbum();\n", "")
old_delete_album = """        if (album != null) {
            boolean hasPublishedTrack = trackRepository.existsByAlbum_IdAndPublicationStatus(
                    album.getId(), TrackPublicationStatus.PUBLISHED
            );
            if (hasPublishedTrack) {
                album.setStatus("PUBLISHED");
            } else {
                album.setStatus("DRAFT");
            }
            albumRepository.save(album);
        }
"""
sts = sts.replace(old_delete_album, "")

old_submit = """        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);
        Album album = track.getAlbumId() != null ? albumRepository.findById(track.getAlbumId()).orElse(null) : null;

        return studioTrackMapper.toStudioTrackResponse(track, genre, album, savedSubmission);"""
new_submit = """        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, savedSubmission);"""
sts = sts.replace(old_submit, new_submit)

old_withdraw = """        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);
        Album album = track.getAlbumId() != null ? albumRepository.findById(track.getAlbumId()).orElse(null) : null;

        return studioTrackMapper.toStudioTrackResponse(track, genre, album, null);"""
new_withdraw = """        Genre genre = genreRepository.findById(track.getGenreId()).orElse(null);

        return studioTrackMapper.toStudioTrackResponse(track, genre, null);"""
sts = sts.replace(old_withdraw, new_withdraw)

old_get_my_albums = """    @Transactional(readOnly = true)
    public List<AlbumOptionResponse> getMyAlbums(String currentUserEmail) {
        AppUser user = getAuthenticatedUser(currentUserEmail);
        return albumRepository.findByCreatedByUserIdOrderByCreatedAtDesc(user.getId())
                .stream()
                .map(studioTrackMapper::toAlbumOption)
                .toList();
    }
"""
sts = sts.replace(old_get_my_albums, "")
with open(sts_path, "w", encoding="utf-8") as f:
    f.write(sts)
print("Updated StudioTrackService.java")

# 10. ModerationServiceTest.java
mst_path = "backend/src/test/java/group03/magisound/moderation/service/ModerationServiceTest.java"
with open(mst_path, "r", encoding="utf-8") as f:
    mst = f.read()

mst = mst.replace("import group03.magisound.catalog.entity.Album;\n", "")
mst = mst.replace("import group03.magisound.catalog.repository.AlbumRepository;\n", "")
mst = mst.replace("    @Mock private AlbumRepository albumRepository;\n", "")

old_mst_setup = """        moderationService = new ModerationService(
                submissionRepository,
                trackRepository,
                albumRepository,
                mailService,
                mapper,
                userRepository,
                profileRepository,
                notificationService
        );"""
new_mst_setup = """        moderationService = new ModerationService(
                submissionRepository,
                trackRepository,
                mailService,
                mapper,
                userRepository,
                profileRepository,
                notificationService
        );"""
mst = mst.replace(old_mst_setup, new_mst_setup)

old_mst_test = """    @Test
    void approveSubmission_Success_And_AutoPublishAlbum() {
        Album draftAlbum = Album.builder()
                .createdByUserId(10L)
                .title("Summer Album")
                .slug("summer-album")
                .status("DRAFT")
                .build();
        ReflectionTestUtils.setField(draftAlbum, "id", 20L);
        testTrack.setAlbum(draftAlbum);

        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.PENDING)
                .submittedAt(Instant.now())
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(userRepository.findByEmailIgnoreCase("staff@soundwave.com")).thenReturn(Optional.of(staffUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));
        when(trackRepository.save(any(Track.class))).thenAnswer(i -> i.getArgument(0));
        when(submissionRepository.save(any(TrackSubmission.class))).thenAnswer(i -> i.getArgument(0));

        ApproveTrackRequest request = new ApproveTrackRequest("Great track!");
        moderationService.approveSubmission(1L, request, "staff@soundwave.com");

        assertEquals(SubmissionStatus.APPROVED, submission.getStatus());
        assertEquals(99L, submission.getReviewerUserId());
        assertEquals("Great track!", submission.getReviewerNote());
        assertEquals(TrackPublicationStatus.PUBLISHED, testTrack.getPublicationStatus());
        assertNotNull(testTrack.getApprovedAt());
        assertEquals("PUBLISHED", draftAlbum.getStatus());
        assertNotNull(draftAlbum.getPublishedAt());

        verify(albumRepository).save(draftAlbum);
        verify(trackRepository).save(testTrack);
        verify(submissionRepository).save(submission);
    }"""

new_mst_test = """    @Test
    void approveSubmission_Success() {
        TrackSubmission submission = TrackSubmission.builder()
                .trackId(100L)
                .submittedByUserId(10L)
                .status(SubmissionStatus.PENDING)
                .submittedAt(Instant.now())
                .build();
        ReflectionTestUtils.setField(submission, "id", 1L);

        when(submissionRepository.findById(1L)).thenReturn(Optional.of(submission));
        when(userRepository.findByEmailIgnoreCase("staff@soundwave.com")).thenReturn(Optional.of(staffUser));
        when(trackRepository.findById(100L)).thenReturn(Optional.of(testTrack));
        when(trackRepository.save(any(Track.class))).thenAnswer(i -> i.getArgument(0));
        when(submissionRepository.save(any(TrackSubmission.class))).thenAnswer(i -> i.getArgument(0));

        ApproveTrackRequest request = new ApproveTrackRequest("Great track!");
        moderationService.approveSubmission(1L, request, "staff@soundwave.com");

        assertEquals(SubmissionStatus.APPROVED, submission.getStatus());
        assertEquals(99L, submission.getReviewerUserId());
        assertEquals("Great track!", submission.getReviewerNote());
        assertEquals(TrackPublicationStatus.PUBLISHED, testTrack.getPublicationStatus());
        assertNotNull(testTrack.getApprovedAt());

        verify(trackRepository).save(testTrack);
        verify(submissionRepository).save(submission);
    }"""
mst = mst.replace(old_mst_test, new_mst_test)
with open(mst_path, "w", encoding="utf-8") as f:
    f.write(mst)
print("Updated ModerationServiceTest.java")

# 11. StudioTrackServiceTest.java
stst_path = "backend/src/test/java/group03/magisound/studio/service/StudioTrackServiceTest.java"
with open(stst_path, "r", encoding="utf-8") as f:
    stst = f.read()
stst = stst.replace("import group03.magisound.catalog.repository.AlbumRepository;\n", "")
stst = stst.replace("    @Mock\n    private AlbumRepository albumRepository;\n", "")
with open(stst_path, "w", encoding="utf-8") as f:
    f.write(stst)
print("Updated StudioTrackServiceTest.java")

print("ALL FIXES APPLIED SUCCESSFULLY!")
