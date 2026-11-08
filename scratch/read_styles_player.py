with open(r"frontend/src/styles.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(280, min(390, len(lines))):
    if any(k in lines[idx] for k in ["music-player", "player-", "queue-"]):
        print(f"{idx+1}: {lines[idx].strip()}")
