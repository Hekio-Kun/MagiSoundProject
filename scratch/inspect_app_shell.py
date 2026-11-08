with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

keywords = [
    "music-app-shell", "sidebar-create-playlist-btn", "sidebar-guest-box",
    "guest-box-title", "app-topbar", "topbar-search", "topbar-nav-btn",
    "topbar-bell-btn", "table-track-row--active", "queue-drawer",
    "queue-track-card", "file-drop-zone", "studio-upload", "filter-pill"
]

for idx, line in enumerate(lines):
    if any(k in line for k in keywords):
        print(f"Line {idx+1}: {line.rstrip()}")
