import os
import re

tsx_dir = r"frontend\src"

inline_dark = []
for root, dirs, files in os.walk(tsx_dir):
    for f in files:
        if f.endswith(('.tsx', '.ts')):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as file:
                lines = file.readlines()
            for idx, line in enumerate(lines):
                if 'style=' in line and ('#' in line or 'rgb' in line or 'color' in line or 'background' in line):
                    inline_dark.append((path, idx+1, line.strip()))

print(f"Total inline style matches: {len(inline_dark)}")
for p, l, text in inline_dark[:30]:
    print(f"{p}:{l} -> {text}")
