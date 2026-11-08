import sys

sys.stdout.reconfigure(encoding='utf-8')
path = r'backend\src\main\java\group03\magisound\moderation\service\ModerationService.java'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Add imports
imports_to_add = '''import group03.magisound.moderation.dto.response.ModerationActivityBundleResponse;
import group03.magisound.moderation.dto.response.ReportResolutionActivityResponse;
import group03.magisound.moderation.dto.response.TrackModerationActivityResponse;
import group03.magisound.moderation.entity.ContentReport;
import group03.magisound.moderation.repository.ContentReportRepository;
'''

if 'import group03.magisound.moderation.dto.response.ModerationActivityBundleResponse;' not in content:
    content = content.replace('import group03.magisound.moderation.repository.TrackSubmissionRepository;',
                              'import group03.magisound.moderation.repository.TrackSubmissionRepository;\n' + imports_to_add)

# Add field injection
if 'ContentReportRepository contentReportRepository;' not in content:
    content = content.replace('private final NotificationService notificationService;',
                              'private final NotificationService notificationService;\n    private final ContentReportRepository contentReportRepository;')

# Add the two methods before the last closing brace
new_methods = '''
    @Transactional(readOnly = true)
    public Map<Long, Long> getModerationCountsByReviewerIds(Collection<Long> reviewerIds) {
        if (reviewerIds == null || reviewerIds.isEmpty()) {
            return Collections.emptyMap();
        }
        List<Object[]> results = submissionRepository.countByReviewerUserIdsAndStatusIn(
                reviewerIds,
                List.of(SubmissionStatus.APPROVED, SubmissionStatus.REJECTED)
        );
        Map<Long, Long> counts = new HashMap<>();
        for (Object[] row : results) {
            Long reviewerId = (Long) row[0];
            Long count = ((Number) row[1]).longValue();
            counts.put(reviewerId, count);
        }
        return counts;
    }

    @Transactional(readOnly = true)
    public ModerationActivityBundleResponse getModerationActivitiesByReviewerId(Long reviewerId) {
        if (reviewerId == null) {
            return new ModerationActivityBundleResponse(0, 0, Collections.emptyList(), Collections.emptyList());
        }

        List<TrackSubmission> submissions = submissionRepository.findByReviewerUserIdOrderByReviewedAtDesc(reviewerId);
        Set<Long> trackIds = submissions.stream().map(TrackSubmission::getTrackId).collect(Collectors.toSet());
        Set<Long> submitterUserIds = submissions.stream().map(TrackSubmission::getSubmittedByUserId).collect(Collectors.toSet());

        Map<Long, Track> trackMap = trackIds.isEmpty() ? Collections.emptyMap() :
                trackRepository.findAllById(trackIds).stream().collect(Collectors.toMap(Track::getId, t -> t));

        Map<Long, String> artistMap = new HashMap<>();
        for (Long userId : submitterUserIds) {
            profileRepository.findByUserId(userId)
                    .ifPresent(p -> artistMap.put(userId, p.getDisplayName() != null ? p.getDisplayName() : p.getUsername()));
        }

        List<TrackModerationActivityResponse> trackReviews = submissions.stream().map(s -> {
            Track t = trackMap.get(s.getTrackId());
            String artistName = artistMap.getOrDefault(s.getSubmittedByUserId(), "User #" + s.getSubmittedByUserId());
            return mapper.toTrackModerationActivityResponse(s, t, artistName);
        }).toList();

        List<ContentReport> reports = contentReportRepository.findByReviewerIdOrderByResolvedAtDesc(reviewerId);
        List<ReportResolutionActivityResponse> reportResolutions = reports.stream().map(r -> {
            Long targetTrackId = r.getTrackId() != null ? r.getTrackId() : r.getTargetId();
            Track t = targetTrackId != null ? trackMap.get(targetTrackId) : null;
            String trackTitle = t != null ? t.getTitle() : "Track #" + targetTrackId;
            return new ReportResolutionActivityResponse(
                    r.getId(),
                    r.getCategory() != null ? r.getCategory() : r.getReason(),
                    r.getTargetType(),
                    targetTrackId,
                    trackTitle,
                    r.getStatus(),
                    r.getResolutionNote() != null ? r.getResolutionNote() : r.getReviewerNote(),
                    r.getResolvedAt() != null ? r.getResolvedAt() : r.getHandledAt()
            );
        }).toList();

        return new ModerationActivityBundleResponse(
                trackReviews.size(),
                reportResolutions.size(),
                trackReviews,
                reportResolutions
        );
    }
}
'''

if 'getModerationActivitiesByReviewerId' not in content:
    last_brace = content.rfind('}')
    content = content[:last_brace] + new_methods

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Updated ModerationService.java successfully')
