import sys

sys.stdout.reconfigure(encoding='utf-8')
path = r'backend\src\test\java\group03\magisound\moderation\service\ModerationServiceTest.java'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('import group03.magisound.moderation.repository.TrackSubmissionRepository;',
                          'import group03.magisound.moderation.repository.TrackSubmissionRepository;\nimport group03.magisound.moderation.repository.ContentReportRepository;')

content = content.replace('@Mock private NotificationService notificationService;',
                          '@Mock private NotificationService notificationService;\n    @Mock private ContentReportRepository contentReportRepository;')

content = content.replace('profileRepository,\n                notificationService\n        );',
                          'profileRepository,\n                notificationService,\n                contentReportRepository\n        );')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Updated ModerationServiceTest.java')
