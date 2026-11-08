with open(r"frontend/src/dashboard.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for i in range(1365, min(1385, len(lines))):
    print(f"{i+1}: {lines[i]}", end="")
