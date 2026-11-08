import re

path = "frontend/src/pages/StudioPage.tsx"
with open(path, "r", encoding="utf-8") as f:
    c = f.read()

# 1. Imports
c = c.replace("type AlbumOption,\n", "")
c = c.replace('import { albumApi } from "../api/album";\n', '')
c = c.replace('import { AlbumFormModal } from "../components/modals/AlbumFormModal";\n', '')
c = c.replace('import { AlbumDetailModal } from "../components/modals/AlbumDetailModal";\n', '')
c = c.replace("StudioAlbum, ", "").replace(", StudioAlbum", "").replace("StudioAlbum", "")

# 2. State
c = re.sub(r'const \[albums, setAlbums\] = useState<[^>]*>\(\[\]\);\s*', '', c)
c = re.sub(r'const \[selectedAlbumId, setSelectedAlbumId\] = useState<[^>]*>\(""\);\s*', '', c)

old_album_block = """  // Navigation: Tracks vs Albums
  const [activeStudioTab, setActiveStudioTab] = useState<"TRACKS" | "ALBUMS">("TRACKS");

  // Albums state (UC-21: Manage My Album)
  const [albumList, setAlbumList] = useState<StudioAlbum[]>([]);
  const [albumFilter, setAlbumFilter] = useState<"ALL" | "PUBLISHED" | "DRAFT">("ALL");
  const [albumSearchQuery, setAlbumSearchQuery] = useState("");
  const [loadingAlbums, setLoadingAlbums] = useState(false);
  const [albumModalOpen, setAlbumModalOpen] = useState(false);
  const [editingAlbum, setEditingAlbum] = useState<StudioAlbum | null>(null);
  const [detailAlbum, setDetailAlbum] = useState<StudioAlbum | null>(null);
  const [deleteConfirmAlbum, setDeleteConfirmAlbum] = useState<StudioAlbum | null>(null);
  const [deletingAlbum, setDeletingAlbum] = useState(false);

  // Load albums from Backend API (UC-21.1)
  const loadAlbums = async () => {
    try {
      setLoadingAlbums(true);
      const data = await albumApi.getMyAlbums();
      setAlbumList(data);
    } catch (err: unknown) {
      console.error("Failed to load studio albums", err);
    } finally {
      setLoadingAlbums(false);
    }
  };

  useEffect(() => {
    void loadAlbums();
  }, []);

  // Delete album handler (UC-21.4 & BR-24 Unlink logic)
  const handleDeleteAlbum = async () => {
    if (!deleteConfirmAlbum) return;
    try {
      setDeletingAlbum(true);
      await albumApi.deleteAlbum(deleteConfirmAlbum.id);
      setActionSuccess(`Album "${deleteConfirmAlbum.title}" deleted successfully. Associated tracks are preserved as standalone tracks.`);
      setDeleteConfirmAlbum(null);
      await Promise.all([loadAlbums(), loadStudioData()]);
    } catch (err: unknown) {
      setActionError(err instanceof Error ? err.message : "Failed to delete album.");
    } finally {
      setDeletingAlbum(false);
    }
  };"""

c = c.replace(old_album_block, "")

# 3. Load data
old_fetch_data = """      const [fetchedTracks, fetchedStats, fetchedGenres, fetchedAlbums] =
        await Promise.all([
          studioApi.getMyTracks(filterStatus),
          studioApi.getStats(),
          studioApi.getGenres(),
          studioApi.getMyAlbums(),
        ]);"""
new_fetch_data = """      const [fetchedTracks, fetchedStats, fetchedGenres] =
        await Promise.all([
          studioApi.getMyTracks(filterStatus),
          studioApi.getStats(),
          studioApi.getGenres(),
        ]);"""
c = c.replace(old_fetch_data, new_fetch_data)

c = c.replace("      setAlbums(fetchedAlbums);\n", "")
c = c.replace("    setSelectedAlbumId(track.albumId ?? \"\");\n", "")
c = c.replace("      albumId: selectedAlbumId ? Number(selectedAlbumId) : undefined,\n", "")

# 4. Album metrics & filters
album_metrics_filter = """  // Album Metrics & Filters (UC-21.1)
  const albumStats = {
    total: albumList.length,
    published: albumList.filter((a) => a.status === "PUBLISHED").length,
    draft: albumList.filter((a) => a.status === "DRAFT").length,
  };

  const filteredAlbums = albumList.filter((album) => {
    const matchesStatus = albumFilter === "ALL" || album.status === albumFilter;
    if (!matchesStatus) return false;
    if (!albumSearchQuery.trim()) return true;
    const q = albumSearchQuery.trim().toLowerCase();
    return (
      album.title.toLowerCase().includes(q) ||
      (album.description && album.description.toLowerCase().includes(q))
    );
  });"""
c = c.replace(album_metrics_filter, "")

# 5. Header button
old_hdr_btn = """        <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
          {activeStudioTab === "TRACKS" ? (
            <button
              className="button button-primary"
              onClick={() => onNavigate("/studio/upload")}
              id="btn-open-create-track"
            >
              <UploadIcon width={18} height={18} />
              <span>Upload track</span>
            </button>
          ) : (
            <button
              className="button button-primary"
              onClick={() => onNavigate("/studio/albums/create")}
              id="btn-open-create-album"
            >
              <PlusIcon width={18} height={18} />
              <span>Create album</span>
            </button>
          )}
        </div>"""
new_hdr_btn = """        <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
          <button
            className="button button-primary"
            onClick={() => onNavigate("/studio/upload")}
            id="btn-open-create-track"
          >
            <UploadIcon width={18} height={18} />
            <span>Upload track</span>
          </button>
        </div>"""
c = c.replace(old_hdr_btn, new_hdr_btn)

# 6. Navigation tabs and activeStudioTab condition
old_tabs_block = """      {/* Studio Navigation Tabs (Tracks vs Albums) */}
      <div
        style={{
          display: "flex",
          gap: "10px",
          borderBottom: "2px solid var(--color-sand-light, #F5EFE6)",
          paddingBottom: "12px",
          marginBottom: "24px",
        }}
      >
        <button
          type="button"
          className={`filter-pill ${activeStudioTab === "TRACKS" ? "filter-pill--active" : ""}`}
          onClick={() => setActiveStudioTab("TRACKS")}
          style={{
            fontSize: "14px",
            fontWeight: 700,
            padding: "8px 20px",
            borderRadius: "20px",
            display: "inline-flex",
            alignItems: "center",
            gap: "8px",
            cursor: "pointer",
          }}
          id="tab-studio-tracks"
        >
          <HeadphonesIcon width={16} height={16} />
          <span>My Tracks ({stats.total})</span>
        </button>
        <button
          type="button"
          className={`filter-pill ${activeStudioTab === "ALBUMS" ? "filter-pill--active" : ""}`}
          onClick={() => setActiveStudioTab("ALBUMS")}
          style={{
            fontSize: "14px",
            fontWeight: 700,
            padding: "8px 20px",
            borderRadius: "20px",
            display: "inline-flex",
            alignItems: "center",
            gap: "8px",
            cursor: "pointer",
          }}
          id="tab-studio-albums"
        >
          <EyeIcon width={16} height={16} />
          <span>My Albums ({albumList.length})</span>
        </button>
      </div>

      {activeStudioTab === "TRACKS" ? (
        <>"""
c = c.replace(old_tabs_block, "")

# 7. End of tracks and ALBUMS tab
album_tab_full = """      </div>
        </>
      ) : (
        <>
          {/* ALBUMS TAB (UC-21: Manage My Album) */}"""

pos = c.find(album_tab_full)
if pos != -1:
    end_marker = "      {/* Edit Track Modal (UC-19.3) */}"
    end_pos = c.find(end_marker, pos)
    if end_pos != -1:
        c = c[:pos] + "      </div>\n\n" + c[end_pos:]
        print("Removed ALBUMS tab successfully")
    else:
        print("End marker not found")
else:
    print("Album tab full marker not found")

# 8. Album dropdown in track modal
c = re.sub(r'\s*<label htmlFor="track-album">Album \(optional\)[\s\S]*?</select>', '', c)

# 9. Album Modals at bottom
modals_marker = "      {/* Album Form Modal (Create / Edit - UC-21.1 & UC-21.3) */}"
pos_modals = c.find(modals_marker)
if pos_modals != -1:
    c = c[:pos_modals] + "\n    </div>\n  );\n}\n"
    print("Removed album modals at bottom successfully")

# 10. Rebranding in this file
c = c.replace("SoundWave", "MagiSound").replace("soundwave", "magisound")
c = c.replace(" & ", " and ")

with open(path, "w", encoding="utf-8") as f:
    f.write(c)

print("Updated StudioPage.tsx completely!")
