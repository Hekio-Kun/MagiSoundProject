with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()
for i in range(1490, min(1585, len(lines))):
    print(f"{i+1}: {lines[i]}", end="")
