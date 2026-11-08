import os
import re

print("Applying remaining frontend fixes...")

# 1. Update frontend/src/types.ts to include NotificationItem
types_path = "frontend/src/types.ts"
with open(types_path, "r", encoding="utf-8") as f:
    types_content = f.read()

if "NotificationItem" not in types_content:
    notification_type_def = """
export type NotificationItem = {
  id: number;
  userId: number;
  type: string;
  title: string;
  message: string;
  targetType?: string;
  targetId?: string;
  isRead: boolean;
  createdAt: string;
};
"""
    types_content += notification_type_def
    with open(types_path, "w", encoding="utf-8") as f:
        f.write(types_content)
    print("Added NotificationItem to types.ts")

# 2. Update frontend/src/api/track.ts to ensure albumId, albumTitle are optional on ApiTrack
track_api_path = "frontend/src/api/track.ts"
with open(track_api_path, "r", encoding="utf-8") as f:
    ta = f.read()

if "albumId?:" not in ta:
    ta = ta.replace("genreName: string;\n  genreSlug: string;\n", "genreName: string;\n  genreSlug: string;\n  albumId?: number;\n  albumTitle?: string;\n")
    with open(track_api_path, "w", encoding="utf-8") as f:
        f.write(ta)
    print("Added albumId?, albumTitle? back to ApiTrack in api/track.ts")

# 3. Fix ExploregPage.tsx
exploreg_path = "frontend/src/components/common/ExploregPage.tsx"
with open(exploreg_path, "r", encoding="utf-8") as f:
    ex = f.read()

ex = ex.replace("albums, ", "").replace(", albums", "")
# Remove featured albums section
ex = re.sub(r'\s*<section className="page-section container">\s*<SectionHeading eyebrow="HEAR THE WHOLE STORY" title="Featured albums"[\s\S]*?</section>', '', ex)
with open(exploreg_path, "w", encoding="utf-8") as f:
    f.write(ex)
print("Fixed ExploregPage.tsx")

# 4. Fix data.ts
data_path = "frontend/src/data.ts"
with open(data_path, "r", encoding="utf-8") as f:
    dt = f.read()

dt = re.sub(r'export const albums:[^=]*=\s*\[[\s\S]*?\];\s*', '', dt)
dt = dt.replace('name: "R&B"', 'name: "R and B"')
with open(data_path, "w", encoding="utf-8") as f:
    f.write(dt)
print("Fixed data.ts")

# 5. Fix components/index.ts
index_path = "frontend/src/components/index.ts"
with open(index_path, "r", encoding="utf-8") as f:
    ci = f.read()

ci = ci.replace('export * from "./common/LandingPage";\n', '')
ci = ci.replace('export * from "./layout/SoundWaveFooter";', 'export * from "./layout/MagiSoundFooter";')
ci = ci.replace('export * from "./layout/SoundWaveHeader";', 'export * from "./layout/MagiSoundHeader";')
with open(index_path, "w", encoding="utf-8") as f:
    f.write(ci)
print("Fixed components/index.ts")

# 6. Fix layouts referencing old header/footer
for layout_f in ["frontend/src/layouts/MarketingLayout.tsx", "frontend/src/layouts/MusicAppShell.tsx", "frontend/src/components/layout/MagiSoundFooter.tsx"]:
    if os.path.exists(layout_f):
        with open(layout_f, "r", encoding="utf-8") as f:
            lc = f.read()
        lc = lc.replace("./SoundWaveHeader", "./MagiSoundHeader")
        lc = lc.replace("./SoundWaveFooter", "./MagiSoundFooter")
        lc = lc.replace("../components/layout/SoundWaveHeader", "../components/layout/MagiSoundHeader")
        lc = lc.replace("../components/layout/SoundWaveFooter", "../components/layout/MagiSoundFooter")
        with open(layout_f, "w", encoding="utf-8") as f:
            f.write(lc)
print("Fixed layouts header/footer imports")

# 7. Fix UploadTrackPage.tsx
upload_path = "frontend/src/pages/UploadTrackPage.tsx"
with open(upload_path, "r", encoding="utf-8") as f:
    up = f.read()

old_upload_promise = """      const [fetchedGenres, fetchedAlbums] = await Promise.all([
        studioApi.getGenres(),
        studioApi.getMyAlbums(),
      ]);
      setGenres(fetchedGenres);"""
new_upload_promise = """      const fetchedGenres = await studioApi.getGenres();
      setGenres(fetchedGenres);"""
up = up.replace(old_upload_promise, new_upload_promise)
with open(upload_path, "w", encoding="utf-8") as f:
    f.write(up)
print("Fixed UploadTrackPage.tsx")

# 8. Fix StudioTrackDetailPage.tsx
detail_path = "frontend/src/pages/StudioTrackDetailPage.tsx"
with open(detail_path, "r", encoding="utf-8") as f:
    std = f.read()

old_std_albums_call = """    studioApi.getMyAlbums().then((a) => {
      if (active && a.length > 0) setAlbums(a);
    }).catch(() => {});"""
std = std.replace(old_std_albums_call, "")
with open(detail_path, "w", encoding="utf-8") as f:
    f.write(std)
print("Fixed StudioTrackDetailPage.tsx")

# 9. Fix StudioPage.tsx
studio_path = "frontend/src/pages/StudioPage.tsx"
with open(studio_path, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = []
skip = False
for line in lines:
    if "// Navigation: Tracks vs Albums" in line or "const loadAlbums = async" in line:
        skip = True
    if skip and "// Load data from Backend API" in line:
        skip = False
    if skip:
        continue

    # In loadStudioData
    if "const [fetchedTracks, fetchedStats, fetchedGenres, fetchedAlbums]" in line:
        line = "      const [fetchedTracks, fetchedStats, fetchedGenres] =\n"
    if "studioApi.getMyAlbums()," in line:
        continue

    # Header button
    if "{activeStudioTab === \"TRACKS\" ? (" in line:
        continue
    if ") : (" in line and new_lines and "Upload track" in "".join(new_lines[-15:]):
        # We are at the album button branch
        skip = True
        continue
    if skip and "</div>" in line:
        skip = False
        new_lines.append("        </div>\n")
        continue

    # Navigation tabs (Tracks vs Albums)
    if "{/* Studio Navigation Tabs (Tracks vs Albums) */}" in line:
        skip = True
        continue
    if skip and "{/* Metrics Row */}" in line:
        skip = False

    # End of tracks table and start of albums tab
    if "{/* ALBUMS TAB (UC-21: Manage My Album) */}" in line:
        skip = True
        continue
    if skip and "{/* Edit Track Modal (UC-19.3) */}" in line:
        skip = False
        new_lines.append("      </div>\n\n      {/* Edit Track Modal (UC-19.3) */}\n")
        continue

    new_lines.append(line)

with open(studio_path, "w", encoding="utf-8") as f:
    f.writelines(new_lines)

# Additional cleanup in StudioPage.tsx
with open(studio_path, "r", encoding="utf-8") as f:
    sp_content = f.read()

sp_content = sp_content.replace("{activeStudioTab === \"TRACKS\" ? (\n        <>\n", "")
sp_content = sp_content.replace("        </>\n      ) : (\n        <>\n", "")
sp_content = re.sub(r'const \[activeStudioTab[^;]*;\n', '', sp_content)
sp_content = re.sub(r'const \[albumList[^;]*;\n', '', sp_content)

with open(studio_path, "w", encoding="utf-8") as f:
    f.write(sp_content)

print("Fixed StudioPage.tsx")
