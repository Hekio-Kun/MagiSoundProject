with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(1340, min(1620, len(lines))):
    if any(k in lines[idx] for k in ["ms-track-card", "ms-leaderboard", "ms-creator-avatar"]):
        print(f"{idx+1}: {lines[idx].strip()}")
