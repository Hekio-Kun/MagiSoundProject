with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(1770, min(2105, len(lines))):
    if any(k in lines[idx] for k in ["sp-quick-play", "sp-floating-play", "sp-genre"]):
        print(f"{idx+1}: {lines[idx].strip()}")
