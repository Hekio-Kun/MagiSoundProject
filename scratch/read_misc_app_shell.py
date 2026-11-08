with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

for idx, line in enumerate(lines):
    if any(k in line for k in [".explore-sort-selector select", ".status-pill--pending", ".auth-title", ".studio-modal-heading .eyebrow", ".profile-avatar-editor small"]):
        for j in range(max(0, idx-2), min(len(lines), idx+10)):
            print(f"{j+1}: {lines[j]}", end="")
        print("---")
