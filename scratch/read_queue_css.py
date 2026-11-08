with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(650, min(840, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
