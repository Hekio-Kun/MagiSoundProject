with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(2065, min(2102, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
