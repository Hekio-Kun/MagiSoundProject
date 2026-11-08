with open(r"frontend/src/styles.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx in range(480, min(520, len(lines))):
    print(f"{idx+1}: {lines[idx]}", end="")
