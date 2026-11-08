import os
import glob
import re

print("Starting frontend refactoring...")

# 1. Update frontend/src/api/track.ts
track_api_path = "frontend/src/api/track.ts"
with open(track_api_path, "r", encoding="utf-8") as f:
    ta = f.read()

ta = re.sub(r'export type AlbumOption = \{[^}]*\};\s*', '', ta)
ta = re.sub(r'  getMyAlbums: \(\) =>\s*studioRequest<AlbumOption\[\]>\("/studio/albums"\),\s*', '', ta)
ta = re.sub(r'  albumId\?: number;\s*', '', ta)
ta = re.sub(r'  albumTitle\?: string;\s*', '', ta)
with open(track_api_path, "w", encoding="utf-8") as f:
    f.write(ta)
print("Updated api/track.ts")

# 2. Update frontend/src/types.ts
types_path = "frontend/src/types.ts"
with open(types_path, "r", encoding="utf-8") as f:
    ty = f.read()

ty = re.sub(r'export type FeaturedAlbum = \{[^}]*\};\s*', '', ty)
ty = re.sub(r'export type AlbumTrackItemPayload = \{[^}]*\};\s*', '', ty)
ty = re.sub(r'export type CreateAlbumPayload = \{[^}]*\};\s*', '', ty)
ty = re.sub(r'export type StudioAlbum = \{[^}]*\};\s*', '', ty)
with open(types_path, "w", encoding="utf-8") as f:
    f.write(ty)
print("Updated types.ts")

# 3. Update frontend/src/components/common/MusicCards.tsx
mc_path = "frontend/src/components/common/MusicCards.tsx"
with open(mc_path, "r", encoding="utf-8") as f:
    mc = f.read()

mc = mc.replace("FeaturedAlbum, ", "").replace(", FeaturedAlbum", "").replace("FeaturedAlbum", "")
# Remove AlbumCard component
album_card_regex = r'export function AlbumCard\([^)]*\)\s*\{[\s\S]*?\n\}\n'
mc = re.sub(album_card_regex, '', mc)
with open(mc_path, "w", encoding="utf-8") as f:
    f.write(mc)
print("Updated components/common/MusicCards.tsx")

# 4. Update frontend/src/data.ts
data_path = "frontend/src/data.ts"
with open(data_path, "r", encoding="utf-8") as f:
    dt = f.read()

dt = dt.replace("FeaturedAlbum, ", "").replace(", FeaturedAlbum", "").replace("FeaturedAlbum", "")
# Remove albums array export
albums_export_regex = r'export const albums: (?:FeaturedAlbum\[\]|\w+\[\])?\s*=\s*\[[\s\S]*?\];\s*'
dt = re.sub(albums_export_regex, '', dt)
# In case it was just `export const albums = [...]`
dt = re.sub(r'export const albums\s*=\s*\[[\s\S]*?\];\s*', '', dt)
with open(data_path, "w", encoding="utf-8") as f:
    f.write(dt)
print("Updated data.ts")

# 5. Update frontend/src/pages/UploadTrackPage.tsx
upload_path = "frontend/src/pages/UploadTrackPage.tsx"
with open(upload_path, "r", encoding="utf-8") as f:
    up = f.read()

up = up.replace("type AlbumOption,", "")
up = re.sub(r'const \[albums, setAlbums\] = useState<[^>]*>\(\[\]\);\s*', '', up)
up = re.sub(r'const \[albumId, setAlbumId\] = useState<[^>]*>\(""\);\s*', '', up)
up = up.replace("const [fetchedGenres, fetchedAlbums] = await Promise.all([\n      studioApi.getGenres(),\n      studioApi.getMyAlbums(),\n    ]);",
                "const fetchedGenres = await studioApi.getGenres();")
up = up.replace("setAlbums(fetchedAlbums);", "")
up = re.sub(r'setAlbumId\(data\.albumId \?\? ""\);\s*', '', up)
up = re.sub(r'albumId: albumId === "" \? undefined : Number\(albumId\),\s*', '', up)
up = re.sub(r'setAlbumId\(""\);\s*', '', up)

# Remove the Album select block
album_select_regex = r'<label htmlFor="upload-track-album">Album[\s\S]*?</select>'
up = re.sub(album_select_regex, '', up)
up = up.replace("The title, genre and optional album details are accurate.", "The title and genre details are accurate.")
with open(upload_path, "w", encoding="utf-8") as f:
    f.write(up)
print("Updated pages/UploadTrackPage.tsx")

# 6. Update frontend/src/pages/StudioTrackDetailPage.tsx
detail_path = "frontend/src/pages/StudioTrackDetailPage.tsx"
with open(detail_path, "r", encoding="utf-8") as f:
    std = f.read()

std = std.replace("type AlbumOption,", "")
std = re.sub(r'const \[albums, setAlbums\] = useState<[^>]*>\(\[\]\);\s*', '', std)
std = re.sub(r'const \[editAlbumId, setEditAlbumId\] = useState<[^>]*>\(""\);\s*', '', std)
std = re.sub(r'studioApi\.getMyAlbums\(\)\.then\(\(a\) => \{\s*if \(active && a\.length > 0\) setAlbums\(a\);\s*\}\);\s*', '', std)
std = re.sub(r'setEditAlbumId\(track\.albumId \?\? ""\);\s*', '', std)
std = re.sub(r'albumId: editAlbumId \? Number\(editAlbumId\) : undefined,\s*', '', std)
# Remove Album select form element
album_edit_select_regex = r'<label htmlFor="edit-track-album">Album \(optional\)[\s\S]*?</select>'
std = re.sub(album_edit_select_regex, '', std)
with open(detail_path, "w", encoding="utf-8") as f:
    f.write(std)
print("Updated pages/StudioTrackDetailPage.tsx")

# 7. Update frontend/src/pages/TrackDetailsPage.tsx
track_det_path = "frontend/src/pages/TrackDetailsPage.tsx"
with open(track_det_path, "r", encoding="utf-8") as f:
    tdp = f.read()
tdp = re.sub(r'<div><dt>Album</dt><dd>[\s\S]*?</dd></div>', '', tdp)
with open(track_det_path, "w", encoding="utf-8") as f:
    f.write(tdp)
print("Updated pages/TrackDetailsPage.tsx")

# 8. Update frontend/src/pages/ExplorePage.tsx
explore_path = "frontend/src/pages/ExplorePage.tsx"
with open(explore_path, "r", encoding="utf-8") as f:
    exp = f.read()
exp = exp.replace("albums, ", "").replace(", albums", "").replace("albums", "")
exp = exp.replace("AlbumCard, ", "").replace(", AlbumCard", "")
# Remove albums section
albums_section_regex = r'<section className="explore-section">[\s\S]*?<SectionHeader[^>]*title="Featured Albums"[\s\S]*?</section>'
exp = re.sub(albums_section_regex, '', exp)
with open(explore_path, "w", encoding="utf-8") as f:
    f.write(exp)
print("Updated pages/ExplorePage.tsx")

# 9. Update frontend/src/pages/SearchPage.tsx
search_path = "frontend/src/pages/SearchPage.tsx"
with open(search_path, "r", encoding="utf-8") as f:
    sp = f.read()
sp = sp.replace("AlbumCard, ", "").replace(", AlbumCard", "")
sp = sp.replace("albums, ", "").replace(", albums", "").replace("albums", "")
with open(search_path, "w", encoding="utf-8") as f:
    f.write(sp)
print("Updated pages/SearchPage.tsx")

# 10. Update frontend/src/pages/StudioPage.tsx
studio_path = "frontend/src/pages/StudioPage.tsx"
with open(studio_path, "r", encoding="utf-8") as f:
    stp = f.read()

stp = stp.replace("type AlbumOption,", "")
stp = stp.replace('import { albumApi } from "../api/album";\n', '')
stp = stp.replace('import { AlbumFormModal } from "../components/modals/AlbumFormModal";\n', '')
stp = stp.replace('import { AlbumDetailModal } from "../components/modals/AlbumDetailModal";\n', '')
stp = stp.replace("StudioAlbum, ", "").replace(", StudioAlbum", "").replace("StudioAlbum", "")
stp = re.sub(r'const \[albums, setAlbums\] = useState<[^>]*>\(\[\]\);\s*', '', stp)
stp = re.sub(r'const \[selectedAlbumId, setSelectedAlbumId\] = useState<[^>]*>\(""\);\s*', '', stp)
stp = re.sub(r'const \[activeStudioTab, setActiveStudioTab\] = useState<[^>]*>\("TRACKS"\);\s*', '', stp)
stp = re.sub(r'// Albums state[\s\S]*?const \[deletingAlbum, setDeletingAlbum\] = useState\(false\);\s*', '', stp)
stp = re.sub(r'// Load albums from Backend API[\s\S]*?setLoadingAlbums\(false\);\s*\}\;\s*', '', stp)
stp = re.sub(r'void loadAlbums\(\);\s*', '', stp)
stp = re.sub(r'// Delete album handler[\s\S]*?setDeletingAlbum\(false\);\s*\}\;\s*', '', stp)
stp = stp.replace("studioApi.getMyAlbums(),\n", "")
stp = stp.replace("setAlbums(fetchedAlbums);", "")
stp = stp.replace("setSelectedAlbumId(track.albumId ?? \"\");", "")
stp = re.sub(r'albumId: selectedAlbumId \? Number\(selectedAlbumId\) : undefined,\s*', '', stp)
stp = re.sub(r'// Album Metrics & Filters[\s\S]*?const filteredAlbums =[\s\S]*?\}\);\s*', '', stp)

# Remove the Create album header button
stp = re.sub(r'<button[^>]*id="btn-open-create-album"[\s\S]*?Create album</span>\s*</button>', '', stp)
# Remove navigation tab for albums
stp = re.sub(r'<button[^>]*id="tab-studio-albums"[\s\S]*?My Albums[\s\S]*?</button>', '', stp)
# Remove albums tab content block
albums_tab_block = r'\{/\* ALBUMS TAB \(UC-21: Manage My Album\) \*\/\}[\s\S]*?\{/\* End of Albums Tab \*\/\}'
stp = re.sub(albums_tab_block, '', stp)
# Remove Album Form Modal and Album Detail Modal renderings
stp = re.sub(r'<AlbumFormModal[\s\S]*?/>', '', stp)
stp = re.sub(r'<AlbumDetailModal[\s\S]*?/>', '', stp)
stp = re.sub(r'<DeleteConfirmationModal[\s\S]*?title="Delete Album"[\s\S]*?/>', '', stp)
# Remove Album column in track table if needed
stp = stp.replace("<th>Album</th>", "")
stp = re.sub(r'<td>\{t\.albumTitle[\s\S]*?\}</td>', '', stp)
# Remove album select in modal
stp = re.sub(r'<label htmlFor="track-album">Album \(optional\)[\s\S]*?</select>', '', stp)

with open(studio_path, "w", encoding="utf-8") as f:
    f.write(stp)
print("Updated pages/StudioPage.tsx")

# 11. Global Rebrand SoundWave -> MagiSound across frontend/src
print("Performing global rebranding...")
rebrand_count = 0
all_src_files = glob.glob("frontend/src/**/*.ts", recursive=True) + glob.glob("frontend/src/**/*.tsx", recursive=True) + glob.glob("frontend/src/**/*.css", recursive=True)

for file_path in all_src_files:
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    orig = content
    content = content.replace("SoundWave", "MagiSound")
    content = content.replace("soundwave", "magisound")
    # Replace & with and in user-facing labels where applicable
    content = content.replace(" & ", " and ")
    if content != orig:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
        rebrand_count += 1

print(f"Rebranded {rebrand_count} files in frontend/src.")
