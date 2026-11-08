with open('frontend/src/components/player/MusicPlayer.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    '<a href={`#/creator/${track.creator.userId}`}>{track.creator.displayName}</a>',
    '<a href={`#/creator/${track.creator?.userId}`}>{track.creator?.displayName || "Artist"}</a>'
)

content = content.replace(
    '<span><b>{item.title}</b><small>{item.creator.displayName}</small></span>',
    '<span><b>{item.title}</b><small>{item.creator?.displayName || "Artist"}</small></span>'
)

with open('frontend/src/components/player/MusicPlayer.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content)

print('Updated MusicPlayer.tsx successfully!')
