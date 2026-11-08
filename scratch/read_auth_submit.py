with open(r"frontend/src/auth-redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(235, min(265, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
