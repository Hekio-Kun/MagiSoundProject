path = "frontend/src/routes/AppRouter.tsx"
with open(path, "r", encoding="utf-8") as f:
    c = f.read()

c = c.replace('import { AlbumDetailsPage } from "../pages/AlbumDetailsPage";\n', '')
c = c.replace('import { CreateAlbumPage } from "../pages/CreateAlbumPage";\n', '')
c = c.replace('import { StudioAlbumDetailPage } from "../pages/StudioAlbumDetailPage";\n', '')

album_route = """  if (pathname.startsWith("/album/")) {
    const albumId = Number(pathname.split("/")[2]) || 1;
    return (
      <AlbumDetailsPage
        albumId={albumId}
        currentTrack={currentTrack}
        playing={playing}
        onPlayTrack={playTrack}
        onNavigate={navigate}
      />
    );
  }
"""
c = c.replace(album_route, "")

studio_album_routes = """  if (pathname === "/studio/albums/create") {
    if (!authReady || !isAuthenticated) return null;
    return (
      <CreateAlbumPage
        isAuthenticated={isAuthenticated}
        canCreate={user?.role === "LISTENER"}
        currentUser={user}
        onNavigate={navigate}
      />
    );
  }

  if (pathname.startsWith("/studio/albums/")) {
    if (!authReady || !isAuthenticated) return null;
    const parts = pathname.split("/");
    const albumId = Number(parts[3]) || null;
    if (!albumId) {
      navigate("/studio");
      return null;
    }
    return (
      <StudioAlbumDetailPage
        albumId={albumId}
        currentUser={user}
        onNavigate={navigate}
        currentTrack={currentTrack}
        playing={playing}
        onPlayTrack={playTrack}
      />
    );
  }
"""
c = c.replace(studio_album_routes, "")

with open(path, "w", encoding="utf-8") as f:
    f.write(c)

print("Updated AppRouter.tsx")
