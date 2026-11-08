import re

files = [
    r"frontend\src\styles.css",
    r"frontend\src\app-shell.css",
    r"frontend\src\redesign.css",
    r"frontend\src\dashboard.css",
    r"frontend\src\auth-redesign.css",
]

def analyze_file(filepath):
    print(f"\n====================================\nFILE: {filepath}\n====================================")
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split into rules
    # Clean comments
    cleaned = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    
    rules = re.findall(r'([^{}]+)\{([^{}]+)\}', cleaned)
    
    dark_bg_rules = []
    for selector, body in rules:
        sel = selector.strip()
        # check background
        bg_match = re.search(r'background(-color)?\s*:\s*([^;]+);', body)
        color_match = re.search(r'(?<![a-zA-Z-])color\s*:\s*([^;]+);', body)
        
        bg_val = bg_match.group(2).strip() if bg_match else ""
        color_val = color_match.group(1).strip() if color_match else ""
        
        # Check if bg is dark
        is_dark_bg = bool(re.search(r'#0|#1|#2|black|rgb\(\s*0|rgba\(\s*0|linear-gradient\([^;]*(#0|#1|#2|black)', bg_val, re.IGNORECASE))
        
        # Check if color is dark or unset
        is_dark_color = bool(re.search(r'#0|#1|#2|#3|#4|#5|#6|#7|black|var\(--text\)|var\(--sw-text\)|var\(--sw-ink\)', color_val, re.IGNORECASE))
        
        if is_dark_bg:
            dark_bg_rules.append((sel, bg_val, color_val))

    print(f"Total dark-background rules found: {len(dark_bg_rules)}")
    for sel, bg, col in dark_bg_rules:
        print(f"Selector: {sel}\n  BG: {bg}\n  Color: {col if col else '[NOT SET - inherits black]'}\n")

for f in files:
    analyze_file(f)
