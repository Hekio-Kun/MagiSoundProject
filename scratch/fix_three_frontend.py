import re

# 1. MusicCards.tsx
mc_path = "frontend/src/components/common/MusicCards.tsx"
with open(mc_path, "r", encoding="utf-8") as f:
    mc = f.read()
mc = re.sub(r'export function AlbumCard[\s\S]*?\n\}\n', '', mc)
with open(mc_path, "w", encoding="utf-8") as f:
    f.write(mc)
print("Fixed MusicCards.tsx")

# 2. ExplorePage.tsx
exp_path = "frontend/src/pages/ExplorePage.tsx"
with open(exp_path, "r", encoding="utf-8") as f:
    exp = f.read()

# remove AlbumCard from import if present
exp = exp.replace("AlbumCard, ", "").replace(", AlbumCard", "").replace("AlbumCard", "")
exp = re.sub(r'\s*<section className="sw-section">\s*<SectionHeader title="Featured "\s*description="Complete stories told through every album"[\s\S]*?</section>', '', exp)
with open(exp_path, "w", encoding="utf-8") as f:
    f.write(exp)
print("Fixed ExplorePage.tsx")

# 3. SearchPage.tsx
sp_path = "frontend/src/pages/SearchPage.tsx"
with open(sp_path, "r", encoding="utf-8") as f:
    sp = f.read()

sp = sp.replace("AlbumCard, ", "").replace(", AlbumCard", "").replace("AlbumCard", "")
# Remove matchedAlbums useMemo
sp = re.sub(r'const matchedAlbums = useMemo[\s\S]*?\], \[query\]\);\s*', '', sp)
# In hasResults:
sp = sp.replace("matchedTracks.length > 0 || matchedAlbums.length > 0 || matchedCreators.length > 0", "matchedTracks.length > 0 || matchedCreators.length > 0")
# Remove tab button for albums if present
sp = re.sub(r'<button[^>]*onClick=\{\(\) => setActiveFilter\(""\)\}[^>]*>[\s\S]*?</button>\s*', '', sp)
# Remove albums results section
sp = re.sub(r'\s*\{\(activeFilter === "all" \|\| activeFilter === ""\) && matchedAlbums\.length > 0 && \([\s\S]*?</section>\s*\)\}', '', sp)
with open(sp_path, "w", encoding="utf-8") as f:
    f.write(sp)
print("Fixed SearchPage.tsx")
