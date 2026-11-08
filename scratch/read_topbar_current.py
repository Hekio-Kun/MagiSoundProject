with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()
for i in range(230, min(420, len(lines))):
    print(f"{i+1}: {lines[i]}", end="")
