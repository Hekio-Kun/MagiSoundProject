with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if any(k in line for k in [".topbar-search", ".explore-sort-selector select", ".status-pill--pending", ".auth-title", ".studio-modal-heading", ".profile-avatar-editor", "album-card-title", "track-creator-name:hover"]):
        print(f"Line {idx+1}: {line.strip()}")
