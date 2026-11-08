package group03.magisound.moderation.mapper;

import group03.magisound.authentication.entity.AppUser;
import group03.magisound.authentication.entity.UserProfile;
import group03.magisound.catalog.entity.Genre;
import group03.magisound.catalog.entity.Track;
import group03.magisound.moderation.dto.response.*;
import group03.magisound.moderation.entity.TrackSubmission;
import org.springframework.stereotype.Component;

/**
 * Mapper chuyển đổi dữ liệu giữa Entity và DTO cho chức năng Kiểm duyệt bài hát (UC-17: Manage Track Moderation).
 */
@Component
public class TrackSubmissionMapper {

    public SubmissionQueueItemResponse toQueueItemResponse(TrackSubmission submission,
                                                           Track track,
                                                           AppUser submitter,
                                                           UserProfile submitterProfile,
                                                           AppUser reviewer,
                                                           UserProfile reviewerProfile) {
        if (submission == null) {
            return null;
        }

        Long trackId = track != null ? track.getId() : submission.getTrackId();
        String trackTitle = track != null ? track.getTitle() : null;
        String genreName = (track != null && track.getGenre() != null) ? track.getGenre().getName() : null;
        String albumTitle = null;
        String coverUrl = track != null ? track.getCoverUrl() : null;
        Integer durationMs = track != null ? track.getDurationMs() : null;

        Long submitterId = submitter != null ? submitter.getId() : submission.getSubmittedByUserId();
        String submitterDisplayName = resolveDisplayName(submitter, submitterProfile);
        String submitterEmail = submitter != null ? submitter.getEmail() : null;
        String reviewerDisplayName = resolveDisplayName(reviewer, reviewerProfile);

        return new SubmissionQueueItemResponse(
                submission.getId(),
                trackId,
                trackTitle,
                genreName,
                albumTitle,
                coverUrl,
                durationMs,
                submitterId,
                submitterDisplayName,
                submitterEmail,
                submission.getStatus(),
                submission.getSubmittedAt(),
                submission.getReviewedAt(),
                reviewerDisplayName
        );
    }

    public SubmissionDetailResponse toDetailResponse(TrackSubmission submission,
                                                     Track track,
                                                     AppUser submitter,
                                                     UserProfile submitterProfile,
                                                     AppUser reviewer,
                                                     UserProfile reviewerProfile) {
        return toDetailResponse(submission, track, submitter, submitterProfile, reviewer, reviewerProfile, null);
    }

    public SubmissionDetailResponse toDetailResponse(TrackSubmission submission,
                                                     Track track,
                                                     AppUser submitter,
                                                     UserProfile submitterProfile,
                                                     AppUser reviewer,
                                                     UserProfile reviewerProfile,
                                                     String lyrics) {
        if (submission == null) {
            return null;
        }

        TrackDetailResponse trackDetail = toTrackDetailResponse(track, lyrics);
        UserSummaryResponse submitterSummary = toUserSummaryResponse(submitter, submitterProfile);
        UserSummaryResponse reviewerSummary = toUserSummaryResponse(reviewer, reviewerProfile);

        return new SubmissionDetailResponse(
                submission.getId(),
                submission.getStatus(),
                submission.getSubmitterNote(),
                submission.getReviewerNote(),
                submission.getRejectionReason(),
                submission.getSubmittedAt(),
                submission.getReviewedAt(),
                trackDetail,
                submitterSummary,
                reviewerSummary
        );
    }

    public TrackDetailResponse toTrackDetailResponse(Track track) {
        return toTrackDetailResponse(track, track != null ? track.getLyrics() : null);
    }

    public TrackDetailResponse toTrackDetailResponse(Track track, String lyrics) {
        if (track == null) {
            return null;
        }

        GenreSummaryResponse genreSummary = toGenreSummaryResponse(track.getGenre());

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
        );
    }

    public GenreSummaryResponse toGenreSummaryResponse(Genre genre) {
        if (genre == null) {
            return null;
        }
        return new GenreSummaryResponse(genre.getId(), genre.getName(), genre.getSlug());
    }

    public UserSummaryResponse toUserSummaryResponse(AppUser user, UserProfile profile) {
        if (user == null && profile == null) {
            return null;
        }
        Long id = user != null ? user.getId() : (profile != null ? profile.getUserId() : null);
        String email = user != null ? user.getEmail() : null;
        return new UserSummaryResponse(
                id,
                email,
                resolveUsername(profile),
                resolveDisplayName(user, profile)
        );
    }

    public TrackModerationActivityResponse toTrackModerationActivityResponse(
            TrackSubmission submission,
            Track track,
            String artistName
    ) {
        if (submission == null) return null;
        String trackTitle = track != null ? track.getTitle() : "Track #" + submission.getTrackId();
        return new TrackModerationActivityResponse(
                submission.getId(),
                submission.getTrackId(),
                trackTitle,
                artistName != null ? artistName : "Unknown Artist",
                submission.getStatus() != null ? submission.getStatus().name() : "PENDING",
                submission.getRejectionReason(),
                submission.getReviewerNote(),
                submission.getReviewedAt()
        );
    }

    private String resolveDisplayName(AppUser user, UserProfile profile) {
        if (profile != null && profile.getDisplayName() != null && !profile.getDisplayName().isBlank()) {
            return profile.getDisplayName();
        }
        if (user != null) {
            return user.getEmail();
        }
        return null;
    }

    private String resolveUsername(UserProfile profile) {
        if (profile != null) {
            return profile.getUsername();
        }
        return null;
    }
}
