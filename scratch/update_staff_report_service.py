import sys

sys.stdout.reconfigure(encoding='utf-8')
path = r'backend\src\main\java\group03\magisound\moderation\service\StaffContentReportService.java'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

target = '''            lyrics = officialLyricRepository.findByTrackId(trackId)
                    .map(OfficialLyric::getLyricContent)
                    .orElse(null);
            if (lyrics == null) {
                lyrics = submissionRepository.findFirstByTrackIdOrderBySubmittedAtDesc(trackId)
                        .map(TrackSubmission::getProposedLyrics)
                        .orElse(null);
            }'''

replacement = '''            lyrics = officialLyricRepository.findByTrackId(trackId)
                    .map(OfficialLyric::getLyricContent)
                    .orElse(null);
            if (lyrics == null && trackOpt.isPresent()) {
                lyrics = trackOpt.get().getLyrics();
            }'''

content = content.replace(target, replacement)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Updated StaffContentReportService.java')
