with open(r"frontend/src/styles.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(85, min(200, len(lines))):
    if any(k in lines[idx] for k in ["site-header", "header-search", "profile-button", "site-footer", "track-card", "hero-kicker"]):
        print(f"{idx+1}: {lines[idx].strip()}")
