with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if ".app-topbar" in line or "upload-track" in line or "studio-upload-progress" in line:
        print(f"app-shell line {idx+1}: {line.strip()}")

print("---")
with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if any(k in line for k in ["ms-bento-spotlight", "ms-leaderboard-play-btn", "ms-leaderboard-row:hover", "ms-track-card"]):
        print(f"redesign line {idx+1}: {line.strip()}")
