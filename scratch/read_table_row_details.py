with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(1500, min(1540, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
