import re
import os

css_files = [
    r"frontend\src\styles.css",
    r"frontend\src\app-shell.css",
    r"frontend\src\redesign.css",
    r"frontend\src\dashboard.css",
    r"frontend\src\auth-redesign.css",
    r"frontend\src\motion.css",
]

dark_patterns = re.compile(r'(background(-color)?\s*:\s*(#[0-2][0-9a-fA-F]{2,5}|black|rgba?\(\s*0\s*,\s*0\s*,\s*0|linear-gradient\([^;]*#[0-2]))', re.IGNORECASE)

for path in css_files:
    if not os.path.exists(path):
        continue
    print(f"\n=================== {path} ===================")
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    current_selector = ""
    for idx, line in enumerate(lines):
        trimmed = line.strip()
        if '{' in trimmed and not trimmed.startswith('@'):
            current_selector = trimmed
        elif trimmed.startswith('.'):
            current_selector = trimmed
        
        if dark_patterns.search(line):
            print(f"Line {idx+1}: {current_selector} -> {trimmed}")
