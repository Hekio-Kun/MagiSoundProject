with open('frontend/src/pages/TrackDetailsPage.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    '{track.creator?.displayName ?? "Unknown Creator"}',
    '{track.creator?.displayName || "Artist"}'
)

with open('frontend/src/pages/TrackDetailsPage.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content)

print('Updated TrackDetailsPage.tsx successfully!')
