with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

print(f"Total lines in redesign.css: {len(lines)}")
for idx in range(1040, min(1240, len(lines))):
    if any(k in lines[idx] for k in ["ms-bento", "ms-btn-details"]):
        print(f"{idx+1}: {lines[idx].strip()}")
