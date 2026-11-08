with open('frontend/src/pages/LibraryPage.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'displayName: item.artistName || "Unknown Artist",',
    'displayName: item.artistName || "Artist",'
)

old_row_creator = '''                    <a
                      className="row-creator"
                      href={`#/creator/${track.creator.userId}`}
                      onClick={(e) => {
                        e.preventDefault();
                        onNavigate(`/creator/${track.creator.userId}`);
                      }}
                    >
                      {track.creator.displayName}
                    </a>'''

new_row_creator = '''                    <a
                      className="row-creator"
                      href={`#/creator/${track.creator?.userId}`}
                      onClick={(e) => {
                        e.preventDefault();
                        if (track.creator?.userId) onNavigate(`/creator/${track.creator.userId}`);
                      }}
                    >
                      {track.creator?.displayName || "Artist"}
                    </a>'''

content_norm = content.replace('\r\n', '\n')
old_norm = old_row_creator.replace('\r\n', '\n')
new_norm = new_row_creator.replace('\r\n', '\n')

if old_norm in content_norm:
    content_norm = content_norm.replace(old_norm, new_norm)

with open('frontend/src/pages/LibraryPage.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content_norm.replace('\n', '\r\n'))

print('Updated LibraryPage.tsx successfully!')
