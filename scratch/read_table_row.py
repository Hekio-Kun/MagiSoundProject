with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(1450, min(1490, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
