import os
import re

css_files = [
    'frontend/src/styles.css',
    'frontend/src/app-shell.css',
    'frontend/src/redesign.css',
    'frontend/src/dashboard.css',
    'frontend/src/auth-redesign.css',
]

color_map = {
    # Purples & Violets -> White / Grayscale
    '#8b5cf6': '#ffffff',
    '#c4b5fd': '#e5e5e5',
    '#a78bfa': '#ffffff',
    '#7c3aed': '#e5e5e5',
    '#6d28d9': '#ffffff',
    '#4c1d95': '#1e1e1e',
    '#1e1b4b': '#121212',
    '#ddd6fe': '#f5f5f5',
    '#ede9fe': '#1a1a1a',
    '#f5f3ff': '#181818',
    '#2e1065': '#101010',

    # Blues & Cyans -> White / Grayscale
    '#0284c7': '#ffffff',
    '#0369a1': '#ffffff',
    '#0e7490': '#ffffff',
    '#38bdf8': '#ffffff',
    '#67e8f9': '#ffffff',
    '#bae6fd': '#e5e5e5',
    '#e0f2fe': '#1f1f1f',
    '#e9fbff': '#141414',
    '#f0f9ff': '#121212',
    '#0891b2': '#ffffff',
    '#065f46': '#1a1a1a',
    '#134e4a': '#141414',
    '#99f6e4': '#ffffff',
    '#ccfbf1': '#202020',
    '#0f766e': '#ffffff',
    '#dbeafe': '#1f1f1f',
    '#1d4ed8': '#ffffff',

    # Sand, Beige & Warm Browns -> Black, Charcoal & White
    '#d4a373': '#ffffff',
    '#b4691e': '#ffffff',
    '#784e25': '#ffffff',
    '#92400e': '#ffffff',
    '#b45309': '#ffffff',
    '#fde68a': '#ffffff',
    '#fed7aa': '#1c1c1c',
    '#c2410c': '#ffffff',
    '#7c2d12': '#121212',
    '#f5ead8': '#1c1c1c',
    '#e8dccb': '#262626',
    '#e6d5b8': '#262626',
    '#e6d8c5': '#262626',
    '#ede3d2': '#262626',
    '#fbf3e5': '#121212',
    '#fdfcf9': '#121212',
    '#fdfaf4': '#0d0d0d',
    '#fffdfa': '#141414',
    '#dec3a6': '#404040',
    '#cb9b51': '#ffffff',

    # Navy / Dark Blues -> Deep Carbon Black
    '#121626': '#121212',
    '#181f34': '#181818',
    '#1a2035': '#1c1c1c',
    '#222a44': '#242424',
    '#161c32': '#161616',
    '#090b14': '#000000',
    '#0d111d': '#0a0a0a',
    '#0b0e19': '#080808',
    '#151928': '#141414',
    '#1e2538': '#1f1f1f',
}

# Regex replacements for rgba(...)
rgba_patterns = [
    (re.compile(r'rgba\(\s*139\s*,\s*92\s*,\s*246\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(255, 255, 255, \1)'),
    (re.compile(r'rgba\(\s*2\s*,\s*132\s*,\s*199\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(255, 255, 255, \1)'),
    (re.compile(r'rgba\(\s*3\s*,\s*105\s*,\s*161\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(255, 255, 255, \1)'),
    (re.compile(r'rgba\(\s*212\s*,\s*163\s*,\s*115\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(255, 255, 255, \1)'),
    (re.compile(r'rgba\(\s*180\s*,\s*140\s*,\s*90\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(0, 0, 0, \1)'),
    (re.compile(r'rgba\(\s*8\s*,\s*47\s*,\s*73\s*,\s*([0-9.]+)\s*\)', re.IGNORECASE), r'rgba(0, 0, 0, \1)'),
]

for cf in css_files:
    if not os.path.exists(cf):
        continue
    with open(cf, 'r', encoding='utf-8') as f:
        content = f.read()

    # Case-insensitive replacement for hex colors
    for k, v in color_map.items():
        pattern = re.compile(re.escape(k), re.IGNORECASE)
        content = pattern.sub(v, content)

    for p, repl in rgba_patterns:
        content = p.sub(repl, content)

    with open(cf, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"Purified monochrome colors in {cf}")
