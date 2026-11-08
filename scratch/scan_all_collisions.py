import re

files = {
    'styles': r'frontend\src\styles.css',
    'app-shell': r'frontend\src\app-shell.css',
    'redesign': r'frontend\src\redesign.css',
    'dashboard': r'frontend\src\dashboard.css',
    'auth-redesign': r'frontend\src\auth-redesign.css'
}

def scan_collisions(filename, filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Remove comments
    cleaned = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)
    
    # Match selector { body }
    rules = re.findall(r'([^{}]+)\{([^{}]+)\}', cleaned)
    
    collisions = []
    dark_elements = []
    
    for sel_raw, body_raw in rules:
        sel = sel_raw.strip().replace('\n', ' ')
        body = body_raw.strip()
        
        # Extract bg
        bgs = re.findall(r'background(?:-color)?\s*:\s*([^;]+);', body)
        colors = re.findall(r'(?<![a-zA-Z-])color\s*:\s*([^;]+);', body)
        
        bg_str = ' '.join(bgs).lower()
        color_str = ' '.join(colors).lower()
        
        # Check if bg is dark
        # dark colors: #0, #1, #2, #3, black, rgb(0, rgba(0, rgba(1, rgba(2, rgba(3
        is_dark_bg = bool(re.search(r'#(?:0[0-9a-f]{2,5}|1[0-9a-f]{2,5}|2[0-9a-f]{2,5}|3[0-3][0-9a-f]{1,4}|black)\b|rgba?\(\s*(?:[0-2]?[0-9]|3[0-5])\s*,\s*(?:[0-2]?[0-9]|3[0-5])\s*,\s*(?:[0-2]?[0-9]|3[0-5])', bg_str))
        
        if is_dark_bg:
            # Check if color is dark or missing
            is_light_color = bool(re.search(r'#(?:f[0-9a-f]{2,5}|e[0-9a-f]{2,5}|d[0-9a-f]{2,5}|white)\b|rgba?\(\s*25[0-5]', color_str))
            
            dark_elements.append({
                'selector': sel,
                'bg': bg_str,
                'color': color_str,
                'has_light_color': is_light_color
            })
            
            if not is_light_color or re.search(r'#000|black', color_str):
                collisions.append({
                    'selector': sel,
                    'bg': bg_str,
                    'color': color_str if color_str else '(UNSET / INHERITED)'
                })
                
    print(f"\n=======================================================")
    print(f"FILE: {filename} ({len(rules)} total rules, {len(dark_elements)} dark backgrounds, {len(collisions)} POTENTIAL COLLISIONS)")
    print(f"=======================================================")
    for c in collisions:
        print(f"  Selector: {c['selector']}")
        print(f"    BG:    {c['bg']}")
        print(f"    Color: {c['color']}")

for k, v in files.items():
    scan_collisions(k, v)
