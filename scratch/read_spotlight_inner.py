with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()
for i in range(931, min(1030, len(lines))):
    print(f"{i+1}: {lines[i]}", end="")
