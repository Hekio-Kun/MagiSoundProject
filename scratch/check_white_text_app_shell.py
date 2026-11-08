with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    content = f.read()

import re

# Look for color: #fff or #ffffff in app-shell.css
matches = re.finditer(r'([^{}]+)\{([^{}]+)\}', content)
for m in matches:
    sel = m.group(1).strip().replace('\n', ' ')
    body = m.group(2).strip()
    if 'color:' in body and any(c in body for c in ['#fff', '#ffffff', 'white']):
        # If it also has a light background or is a general text element
        if any(bg in body for bg in ['background: #fff', 'background: #f', 'background: #e', 'background: white', 'background: transparent']) or 'background' not in body:
            print(f"SELECTOR: {sel}")
            for line in body.split(';'):
                if 'color' in line or 'background' in line:
                    print(f"   {line.strip()}")
