with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()
for i in range(930, min(960, len(lines))):
    print(f"redesign {i+1}: {lines[i]}", end="")

print("---")
with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()
for i in range(1030, min(1050, len(lines))):
    print(f"app-shell {i+1}: {lines[i]}", end="")
