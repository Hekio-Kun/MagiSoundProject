import os

def replace_in_file(path, old, new):
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    if old not in content:
        print(f"WARNING: Target not found in {path}")
        return False
    content = content.replace(old, new)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Updated {path}")
    return True

# 1. TrackRepository.java
track_repo_path = "backend/src/main/java/group03/magisound/catalog/repository/TrackRepository.java"
with open(track_repo_path, "r", encoding="utf-8") as f:
    tr_content = f.read()

tr_old = """    boolean existsByAlbum_Id(Long albumId);

    List<Track> findByAlbum_IdOrderByTrackNumberAsc(Long albumId);

    long countByAlbum_Id(Long albumId);

    boolean existsByAlbum_IdAndPublicationStatus(Long albumId, TrackPublicationStatus publicationStatus);

    List<Track> findByUploaderUserIdAndAlbumIsNullOrderByCreatedAtDesc(Long uploaderUserId);

    @Modifying
    @Query("UPDATE Track t SET t.album = null, t.trackNumber = null, t.updatedAt = CURRENT_TIMESTAMP WHERE t.album.id = :albumId AND t.uploaderUserId = :userId")
    void unlinkAlbumFromTracks(@Param("albumId") Long albumId, @Param("userId") Long userId);"""

if tr_old in tr_content:
    tr_content = tr_content.replace(tr_old, "")
    with open(track_repo_path, "w", encoding="utf-8") as f:
        f.write(tr_content)
    print("Updated TrackRepository.java")
else:
    print("WARNING: TrackRepository old block not found")

# 2. TrackCatalogService.java
track_cat_path = "backend/src/main/java/group03/magisound/catalog/service/TrackCatalogService.java"
replace_in_file(track_cat_path,
    """                            || (t.getDescription() != null && t.getDescription().toLowerCase().contains(lowerSearch))
                            || (t.getAlbum() != null && t.getAlbum().getTitle() != null && t.getAlbum().getTitle().toLowerCase().contains(lowerSearch)))""",
    """                            || (t.getDescription() != null && t.getDescription().toLowerCase().contains(lowerSearch)))""")

replace_in_file(track_cat_path,
    """        TrackResponse.TrackAlbumSummary albumSummary = null;
        if (track.getAlbum() != null) {
            albumSummary = new TrackResponse.TrackAlbumSummary(
                    track.getAlbum().getId(),
                    track.getAlbum().getTitle()
            );
        }""",
    """        TrackResponse.TrackAlbumSummary albumSummary = null;""")

# 3. PlaylistService.java
playlist_serv_path = "backend/src/main/java/group03/magisound/library/service/PlaylistService.java"
replace_in_file(playlist_serv_path,
    """        TrackResponse.TrackAlbumSummary albumSummary = null;
        if (track.getAlbum() != null) {
            albumSummary = new TrackResponse.TrackAlbumSummary(
                    track.getAlbum().getId(),
                    track.getAlbum().getTitle()
            );
        }""",
    """        TrackResponse.TrackAlbumSummary albumSummary = null;""")

# 4. TrackDetailResponse.java
track_detail_path = "backend/src/main/java/group03/magisound/moderation/dto/response/TrackDetailResponse.java"
replace_in_file(track_detail_path,
    """ * @param genre                 Thông tin tóm tắt thể loại âm nhạc
 * @param album                 Thông tin tóm tắt album
 * @param lyrics                Lời bài hát (nội dung text/lrc)
 */
public record TrackDetailResponse(
        Long id,
        String title,
        String slug,
        String description,
        Integer trackNumber,
        String publicationStatus,
        String audioUrl,
        String audioFormat,
        Integer durationMs,
        String coverUrl,
        Long playCount,
        LocalDateTime approvedAt,
        String latestRejectionReason,
        LocalDateTime createdAt,
        GenreSummaryResponse genre,
        AlbumSummaryResponse album,
        String lyrics
) {}""",
    """ * @param genre                 Thông tin tóm tắt thể loại âm nhạc
 * @param lyrics                Lời bài hát (nội dung text/lrc)
 */
public record TrackDetailResponse(
        Long id,
        String title,
        String slug,
        String description,
        Integer trackNumber,
        String publicationStatus,
        String audioUrl,
        String audioFormat,
        Integer durationMs,
        String coverUrl,
        Long playCount,
        LocalDateTime approvedAt,
        String latestRejectionReason,
        LocalDateTime createdAt,
        GenreSummaryResponse genre,
        String lyrics
) {}""")

# 5. TrackSubmissionMapper.java
track_mapper_path = "backend/src/main/java/group03/magisound/moderation/mapper/TrackSubmissionMapper.java"
replace_in_file(track_mapper_path,
    "import group03.magisound.catalog.entity.Album;\n",
    "")
replace_in_file(track_mapper_path,
    "String albumTitle = (track != null && track.getAlbum() != null) ? track.getAlbum().getTitle() : null;",
    "String albumTitle = null;")

replace_in_file(track_mapper_path,
    """        GenreSummaryResponse genreSummary = toGenreSummaryResponse(track.getGenre());
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
        );""",
    """        GenreSummaryResponse genreSummary = toGenreSummaryResponse(track.getGenre());

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
        );""")

replace_in_file(track_mapper_path,
    """    /**
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
""", "")

# 6. ModerationService.java
mod_serv_path = "backend/src/main/java/group03/magisound/moderation/service/ModerationService.java"
replace_in_file(mod_serv_path, "import group03.magisound.catalog.entity.Album;\n", "")
replace_in_file(mod_serv_path, "import group03.magisound.catalog.repository.AlbumRepository;\n", "")
replace_in_file(mod_serv_path, "    private final AlbumRepository albumRepository;\n", "")

mod_auto_publish = """        // 6. Quy tắc nghiệp vụ BR-18: Tự động kích hoạt xuất bản Album nếu Album đang ở trạng thái DRAFT
        Album album = track.getAlbum();
        if (album != null && "DRAFT".equalsIgnoreCase(album.getStatus())) {
            album.setStatus("PUBLISHED");
            album.setPublishedAt(nowUtc);
            albumRepository.save(album);
        }
        trackRepository.save(track);"""

replace_in_file(mod_serv_path, mod_auto_publish, "        trackRepository.save(track);")

# 7. StudioTrackController.java
studio_ctrl_path = "backend/src/main/java/group03/magisound/studio/controller/StudioTrackController.java"
replace_in_file(studio_ctrl_path, "import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")

# 8. StudioTrackMapper.java
studio_mapper_path = "backend/src/main/java/group03/magisound/studio/mapper/StudioTrackMapper.java"
replace_in_file(studio_mapper_path, "import group03.magisound.catalog.entity.Album;\n", "")
replace_in_file(studio_mapper_path, "import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")

studio_mapper_old = """    public StudioTrackResponse toStudioTrackResponse(Track track, Genre genre, Album album, TrackSubmission latestSubmission) {
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

studio_mapper_new = """    public StudioTrackResponse toStudioTrackResponse(Track track, Genre genre, TrackSubmission latestSubmission) {
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

replace_in_file(studio_mapper_path, studio_mapper_old, studio_mapper_new)

studio_mapper_album_opt = """    public AlbumOptionResponse toAlbumOption(Album album) {
        return new AlbumOptionResponse(
                album.getId(),
                album.getTitle(),
                album.getSlug()
        );
    }"""

replace_in_file(studio_mapper_path, studio_mapper_album_opt, "")

# 9. StudioTrackService.java
studio_serv_path = "backend/src/main/java/group03/magisound/studio/service/StudioTrackService.java"
with open(studio_serv_path, "r", encoding="utf-8") as f:
    ss_content = f.read()

# Let's inspect and clean StudioTrackService
replace_in_file(studio_serv_path, "import group03.magisound.catalog.entity.Album;\n", "")
replace_in_file(studio_serv_path, "import group03.magisound.catalog.repository.AlbumRepository;\n", "")
replace_in_file(studio_serv_path, "import group03.magisound.studio.dto.response.AlbumOptionResponse;\n", "")
replace_in_file(studio_serv_path, "    private final AlbumRepository albumRepository;\n", "")

print("StudioTrackService basic imports removed.")
