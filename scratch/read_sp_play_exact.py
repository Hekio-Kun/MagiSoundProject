with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(1775, min(1815, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")

print("---")
for idx in range(1920, min(1955, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
