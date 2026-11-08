import os
import re

print("Starting Spotify Light Theme application...")

# 1. Update frontend/src/styles.css
styles_path = "frontend/src/styles.css"
with open(styles_path, "r", encoding="utf-8") as f:
    styles = f.read()

# Replace root in styles.css
root_light = """:root {
  font-family: "Plus Jakarta Sans", Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: #000000;
  background: #ffffff;
  font-synthesis: none;
  text-rendering: optimizeLegibility;

  /* Pure Light Monochrome Palette (White Background, Black Text) */
  --brand: #000000;
  --brand-dark: #18181b;
  --brand-light: #f4f4f5;
  --brand-glow: rgba(0, 0, 0, 0.08);

  --accent-cyan: #000000;
  --accent-emerald: #10b981;
  --accent-glow: rgba(0, 0, 0, 0.06);

  /* Clean Light Monochrome Surfaces */
  --ms-bg: #ffffff;
  --ms-surface-0: #ffffff;
  --ms-surface-1: #fafafa;
  --ms-surface-2: #f4f4f5;
  --ms-surface-3: #e4e4e7;
  --ms-border: #e4e4e7;
  --ms-border-hover: #000000;

  /* Legacy variable mappings remapped to Light Monochrome */
  --sand: #000000;
  --sand-warm: #ffffff;
  --sand-deep: #000000;
  --sand-chip: #f4f4f5;
  --text: #000000;
  --muted: #71717a;
  --line: #e4e4e7;
  --surface: #ffffff;
  --container: 1360px;

  --sw-bg: #ffffff;
  --sw-surface: #ffffff;
  --sw-surface-subtle: #fafafa;
  --sw-border: #e4e4e7;
  --sw-border-hover: #000000;
  --sw-text-primary: #000000;
  --sw-text-secondary: #52525b;
  --sw-text-muted: #71717a;
  --sw-brand: #000000;
  --sw-brand-dark: #18181b;
  --sw-brand-light: #f4f4f5;

  --sw-danger: #ef4444;
  --sw-danger-dark: #dc2626;
  --sw-danger-light: rgba(239, 68, 68, 0.1);
  --sw-success: #10b981;
  --sw-warning: #f59e0b;
}"""

# Replace root
styles = re.sub(r':root\s*\{[^}]*--sw-warning:[^}]*\}', root_light, styles, flags=re.DOTALL)

# Update body
styles = re.sub(r'body\s*\{[^}]*\}', 'body { margin: 0; min-width: 320px; min-height: 100vh; background: #ffffff; color: #000000; }', styles, count=1)

# Update buttons in styles.css
styles = styles.replace(
    '.button-primary { background: #ffffff !important; color: #000000 !important; font-weight: 800; border: 1px solid #ffffff !important; box-shadow: 0 4px 16px rgba(255, 255, 255, 0.18); }',
    '.button-primary { background: #000000 !important; color: #ffffff !important; font-weight: 700; border: 1px solid #000000 !important; box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15); }'
)
styles = styles.replace(
    '.button-primary:hover { background: #e5e5e5 !important; color: #000000 !important; transform: translateY(-1px); box-shadow: 0 6px 22px rgba(255, 255, 255, 0.28); }',
    '.button-primary:hover { background: #27272a !important; color: #ffffff !important; transform: translateY(-1px); box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2); }'
)
styles = styles.replace(
    '.button-secondary { background: #141414; color: #ffffff; border: 1px solid #333333; }',
    '.button-secondary { background: #f4f4f5; color: #000000; border: 1px solid #e4e4e7; }'
)
styles = styles.replace(
    '.button-secondary:hover { background: #222222; border-color: #ffffff; box-shadow: 0 4px 14px rgba(255, 255, 255, 0.1); }',
    '.button-secondary:hover { background: #e4e4e7; border-color: #000000; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); }'
)

# Update .music-player in styles.css
old_player_regex = r'\.music-player\s*\{[^}]*\}'
new_player = """.music-player {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  width: 100%;
  max-width: 100%;
  margin: 0;
  z-index: 60;
  height: 86px;
  display: grid;
  grid-template-columns: minmax(240px, 1fr) minmax(400px, 2fr) minmax(220px, 1fr);
  align-items: center;
  gap: 24px;
  padding: 10px clamp(20px, 3.5vw, 40px);
  border-radius: 0;
  border-top: 1px solid #e5e7eb;
  border-inline: 0;
  border-bottom: 0;
  background: rgba(255, 255, 255, 0.96);
  box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.06);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  transition: transform 0.24s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.24s ease;
}"""

styles = re.sub(old_player_regex, new_player, styles, count=1)

# Update player play button
styles = re.sub(
    r'\.player-play\s*\{[^}]*\}',
    """.player-play {
  width: 40px;
  height: 40px;
  display: grid;
  place-items: center;
  margin-inline: 4px;
  border: 0;
  border-radius: 50%;
  color: #ffffff;
  background: #000000;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  transition: transform 0.18s ease, box-shadow 0.18s ease;
}""",
    styles,
    count=1
)

# Range slider in styles.css
styles = styles.replace(
    'background: linear-gradient(\n    to right,\n    #ffffff 0%,\n    #0ea5e9 var(--range-progress),\n    #eadecb var(--range-progress),\n    #eadecb 100%\n  );',
    'background: linear-gradient(to right, #000000 0%, #000000 var(--range-progress), #e5e7eb var(--range-progress), #e5e7eb 100%);'
)

# Thumb
styles = re.sub(
    r'\.music-player input\[type="range"\]::-webkit-slider-thumb\s*\{[^}]*\}',
    """.music-player input[type="range"]::-webkit-slider-thumb {
  width: 12px;
  height: 12px;
  appearance: none;
  border-radius: 50%;
  background: #000000;
  border: 2px solid #ffffff;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  transition: transform 0.15s ease;
}""",
    styles,
    count=1
)

with open(styles_path, "w", encoding="utf-8") as f:
    f.write(styles)
print("Updated frontend/src/styles.css for Light Theme.")

# 2. Update frontend/src/app-shell.css
shell_path = "frontend/src/app-shell.css"
with open(shell_path, "r", encoding="utf-8") as f:
    shell = f.read()

shell = shell.replace("background-color: var(--ms-bg, #000000);", "background-color: var(--ms-bg, #ffffff);")
shell = shell.replace("background: #000000;", "background: #ffffff;")
shell = shell.replace("border-right: 1px solid #1c1c1c;", "border-right: 1px solid #e5e7eb;")
shell = shell.replace("border-bottom: 1px solid rgba(255, 255, 255, 0.07);", "border-bottom: 1px solid #e5e7eb;")
shell = shell.replace("color: #f8fafc;", "color: #000000;")

with open(shell_path, "w", encoding="utf-8") as f:
    f.write(shell)
print("Updated frontend/src/app-shell.css for Light Theme.")

# 3. Update frontend/src/redesign.css root and components
redesign_path = "frontend/src/redesign.css"
with open(redesign_path, "r", encoding="utf-8") as f:
    redesign = f.read()

redesign_root_light = """:root {
  --sw-primary: #000000;
  --sw-primary-dark: #18181b;
  --sw-accent: #000000;
  --sw-sand: #000000;
  --sw-sand-warm: #ffffff;
  --sw-sand-deep: #000000;
  --sw-sand-border: #e4e4e7;
  --sw-sand-chip: #f4f4f5;
  --sw-bg: #ffffff;
  --sw-surface: #ffffff;
  --sw-surface-subtle: #fafafa;
  --sw-text: #000000;
  --sw-text-secondary: #52525b;
  --sw-muted: #71717a;
  --sw-border: #e4e4e7;
  --sw-danger: #ef4444;
  --sw-danger-dark: #dc2626;
  --sw-danger-light: rgba(239, 68, 68, 0.1);
  --sw-shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.05);
  --sw-shadow-md: 0 8px 24px rgba(0, 0, 0, 0.08);
}"""

redesign = re.sub(r':root\s*\{[^}]*--sw-shadow-md:[^}]*\}', redesign_root_light, redesign, flags=re.DOTALL)

# Sidebar, Topbar, Search in redesign.css
redesign = redesign.replace("background: #000000;", "background: #ffffff;")
redesign = redesign.replace("border-right: 1px solid #1c1c1c;", "border-right: 1px solid #e5e7eb;")
redesign = redesign.replace("border-bottom: 1px solid #1c1c1c;", "border-bottom: 1px solid #e5e7eb;")
redesign = redesign.replace("background: rgba(0, 0, 0, 0.88);", "background: rgba(255, 255, 255, 0.94);")
redesign = redesign.replace("background: #121212;", "background: #ffffff;")
redesign = redesign.replace("background: #101010;", "background: #ffffff;")
redesign = redesign.replace("background: #0d0d0d;", "background: #f4f4f5;")
redesign = redesign.replace("background: #141414;", "background: #f4f4f5;")
redesign = redesign.replace("background: #181818;", "background: #f4f4f5;")
redesign = redesign.replace("color: #a3a3a3;", "color: #71717a;")
redesign = redesign.replace("color: #ffffff;", "color: #000000;")
redesign = redesign.replace("border: 1px solid #262626;", "border: 1px solid #e4e4e7;")
redesign = redesign.replace("border: 1px solid #222222;", "border: 1px solid #e4e4e7;")
redesign = redesign.replace("border: 1px solid #1f1f1f;", "border: 1px solid #e5e7eb;")

# Topbar search & buttons in redesign.css
redesign = redesign.replace("topbar-search { height: 44px; max-width: 520px; border-radius: 13px; background: #ffffff; border: 1px solid #e4e4e7;", "topbar-search { height: 44px; max-width: 520px; border-radius: 13px; background: #f4f4f5; border: 1px solid #e4e4e7;")
redesign = redesign.replace("topbar-upload-btn { border-radius: 9999px; border: 1px solid #000000 !important; background: #000000 !important; color: #ffffff !important;", "topbar-upload-btn { border-radius: 9999px; border: 1px solid #000000 !important; background: #000000 !important; color: #ffffff !important;")

with open(redesign_path, "w", encoding="utf-8") as f:
    f.write(redesign)
print("Updated frontend/src/redesign.css for Light Theme.")

# 4. Update dashboard.css
db_path = "frontend/src/dashboard.css"
if os.path.exists(db_path):
    with open(db_path, "r", encoding="utf-8") as f:
        db = f.read()
    db = db.replace("#000000", "#ffffff")
    db = db.replace("#080808", "#fafafa")
    db = db.replace("#121212", "#ffffff")
    db = db.replace("#181818", "#f4f4f5")
    db = db.replace("#262626", "#e4e4e7")
    with open(db_path, "w", encoding="utf-8") as f:
        f.write(db)
    print("Updated frontend/src/dashboard.css for Light Theme.")

# 5. Update auth-redesign.css
auth_path = "frontend/src/auth-redesign.css"
if os.path.exists(auth_path):
    with open(auth_path, "r", encoding="utf-8") as f:
        auth = f.read()
    auth = auth.replace("background: #000000;", "background: #ffffff;")
    auth = auth.replace("background-color: #000000;", "background-color: #ffffff;")
    auth = auth.replace("background: #121212;", "background: #ffffff;")
    auth = auth.replace("border-color: #262626;", "border-color: #e4e4e7;")
    auth = auth.replace("color: #ffffff;", "color: #000000;")
    with open(auth_path, "w", encoding="utf-8") as f:
        f.write(auth)
    print("Updated frontend/src/auth-redesign.css for Light Theme.")

print("All CSS files updated successfully.")
