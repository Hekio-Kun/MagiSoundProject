with open('frontend/src/pages/ExplorePage.tsx', 'r', encoding='utf-8') as f:
    code = f.read()

# 1. Add popularArtists memo
old_memos = '''  // New Releases Shelf tracks (top 5)
  const newReleasesShelfTracks = useMemo(() => {
    const list = catalogTracks.length > 0 ? catalogTracks : projectTracks;
    return list.slice(0, 5);
  }, [catalogTracks]);'''

new_memos = '''  // New Releases Shelf tracks (top 5)
  const newReleasesShelfTracks = useMemo(() => {
    const list = catalogTracks.length > 0 ? catalogTracks : projectTracks;
    return list.slice(0, 5);
  }, [catalogTracks]);

  // Popular Artists shelf: dynamically derived from creators present in catalog, fallback to featuredCreators
  const popularArtists = useMemo(() => {
    const map = new Map<number, { userId: number; displayName: string; avatarUrl: string; bio: string; publishedTracks: number; followersCount: number }>();
    for (const track of [...trendingTracks, ...catalogTracks]) {
      if (track.creator && track.creator.userId && !map.has(track.creator.userId)) {
        const existingFeatured = featuredCreators.find((f) => f.userId === track.creator.userId);
        map.set(track.creator.userId, {
          userId: track.creator.userId,
          displayName: track.creator.displayName || "Artist",
          avatarUrl: track.creator.avatarUrl || track.coverUrl || "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80",
          bio: existingFeatured?.bio || "Verified creator on MagiSound.",
          publishedTracks: existingFeatured?.publishedTracks || 1,
          followersCount: existingFeatured?.followersCount || 45000,
        });
      }
    }
    const fromTracks = Array.from(map.values());
    if (fromTracks.length >= 5) {
      return fromTracks.slice(0, 5);
    }
    return featuredCreators.slice(0, 5);
  }, [trendingTracks, catalogTracks]);'''

# 2. Update card display names with fallbacks
code_norm = code.replace('\r\n', '\n')
old_memos_norm = old_memos.replace('\r\n', '\n')
new_memos_norm = new_memos.replace('\r\n', '\n')

assert old_memos_norm in code_norm, 'old_memos not found in ExplorePage.tsx'
code_norm = code_norm.replace(old_memos_norm, new_memos_norm)

# Quick Access fallback
code_norm = code_norm.replace(
    '<span className="sp-quick-artist">{track.creator?.displayName}</span>',
    '<span className="sp-quick-artist">{track.creator?.displayName || "Artist"}</span>'
)

# Trending Now fallback
old_trending_link = '''                  <a
                    href={`#/creator/${track.creator.userId}`}
                    className="sp-card-subtitle"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      onNavigate(`/creator/${track.creator.userId}`);
                    }}
                  >
                    {track.creator.displayName}
                  </a>'''

new_trending_link = '''                  <a
                    href={`#/creator/${track.creator?.userId}`}
                    className="sp-card-subtitle"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      if (track.creator?.userId) onNavigate(`/creator/${track.creator.userId}`);
                    }}
                  >
                    {track.creator?.displayName || "Artist"}
                  </a>'''

assert old_trending_link.replace('\r\n', '\n') in code_norm, 'old_trending_link not found'
code_norm = code_norm.replace(old_trending_link.replace('\r\n', '\n'), new_trending_link.replace('\r\n', '\n'))

# New Releases fallback
old_new_link = '''                  <a
                    href={`#/creator/${track.creator.userId}`}
                    className="sp-card-subtitle"
                    onClick={(e) => {
                      e.preventDefault();
                      e.stopPropagation();
                      onNavigate(`/creator/${track.creator.userId}`);
                    }}
                  >
                    {track.creator.displayName}
                  </a>'''

# Notice old_new_link was identical, replace first one already replaced Trending, replacing again replaces New Releases!
if old_new_link.replace('\r\n', '\n') in code_norm:
    code_norm = code_norm.replace(old_new_link.replace('\r\n', '\n'), new_trending_link.replace('\r\n', '\n'))

# Popular Artists map
code_norm = code_norm.replace(
    '{featuredCreators.slice(0, 5).map((creator) => (',
    '{popularArtists.map((creator) => ('
)

with open('frontend/src/pages/ExplorePage.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(code_norm.replace('\n', '\r\n'))

print('Successfully updated frontend/src/pages/ExplorePage.tsx!')
