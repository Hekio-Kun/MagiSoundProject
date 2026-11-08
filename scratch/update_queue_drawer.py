with open('frontend/src/components/player/QueueDrawer.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    '<p className="queue-track-artist">{currentTrack.creator.displayName}</p>',
    '<p className="queue-track-artist">{currentTrack.creator?.displayName || "Artist"}</p>'
)

content = content.replace(
    '<p className="queue-track-artist">{item.creator.displayName}</p>',
    '<p className="queue-track-artist">{item.creator?.displayName || "Artist"}</p>'
)

with open('frontend/src/components/player/QueueDrawer.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content)

print('Updated QueueDrawer.tsx successfully!')
