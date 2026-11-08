import re

with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

dark_re = re.compile(r'background(?:-color)?\s*:\s*([^;]+);')

for idx, line in enumerate(lines[:1030]):
    m = dark_re.search(line)
    if m:
        bg = m.group(1).lower()
        if any(d in bg for d in ['#0', '#1', '#2', 'black', 'rgb(0', 'rgba(0', 'rgba(1', 'rgba(2']):
            print(f"Line {idx+1}: {line.strip()}")
