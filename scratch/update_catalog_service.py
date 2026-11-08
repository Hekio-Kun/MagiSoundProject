import sys

sys.stdout.reconfigure(encoding='utf-8')
path = r'backend\src\main\java\group03\magisound\catalog\service\TrackCatalogService.java'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('private TrackResponse mapToTrackResponse(Track track) {',
                          'public TrackResponse mapToTrackResponse(Track track) {')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Updated TrackCatalogService.java')
