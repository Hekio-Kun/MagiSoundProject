with open(r"frontend/src/auth-redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

print(f"Total lines in auth-redesign.css: {len(lines)}")
for idx in range(120, min(240, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
