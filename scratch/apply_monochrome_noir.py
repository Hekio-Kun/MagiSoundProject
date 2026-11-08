import re

def update_styles():
    path = "frontend/src/styles.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # New Root with Monochrome Palette
    new_root = ''':root {
  font-family: "Plus Jakarta Sans", Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: #ffffff;
  background: #000000;
  font-synthesis: none;
  text-rendering: optimizeLegibility;

  /* Pure Monochrome Black & White Palette */
  --brand: #ffffff;
  --brand-dark: #e5e5e5;
  --brand-light: #262626;
  --brand-glow: rgba(255, 255, 255, 0.25);

  --accent-cyan: #ffffff;
  --accent-emerald: #10b981;
  --accent-glow: rgba(255, 255, 255, 0.2);

  /* Deep Monochrome Surfaces */
  --ms-bg: #000000;
  --ms-surface-0: #080808;
  --ms-surface-1: #121212;
  --ms-surface-2: #1c1c1c;
  --ms-surface-3: #262626;
  --ms-border: #282828;
  --ms-border-hover: rgba(255, 255, 255, 0.4);

  /* Legacy variable mappings remapped to Monochrome Theme */
  --sand: #ffffff;
  --sand-warm: #000000;
  --sand-deep: #ffffff;
  --sand-chip: #1c1c1c;
  --text: #ffffff;
  --muted: #a3a3a3;
  --line: #282828;
  --surface: #121212;
  --container: 1360px;

  --sw-bg: #000000;
  --sw-surface: #121212;
  --sw-surface-subtle: #080808;
  --sw-border: #282828;
  --sw-border-hover: rgba(255, 255, 255, 0.4);
  --sw-text-primary: #ffffff;
  --sw-text-secondary: #a3a3a3;
  --sw-text-muted: #737373;
  --sw-brand: #ffffff;
  --sw-brand-dark: #e5e5e5;
  --sw-brand-light: #262626;

  --sw-danger: #ef4444;
  --sw-danger-dark: #dc2626;
  --sw-danger-light: rgba(239, 68, 68, 0.15);
  --sw-success: #10b981;
  --sw-warning: #f59e0b;
}'''

    content = re.sub(r':root\s*\{[^}]*\}', new_root, content, count=1)
    content = re.sub(r'body\s*\{[^}]*\}', 'body { margin: 0; min-width: 320px; min-height: 100vh; background: #000000; color: #ffffff; }', content)

    # Primary Button (High contrast white pill, black text)
    content = re.sub(
        r'\.button-primary\s*\{[^}]*\}',
        '.button-primary { background: #ffffff !important; color: #000000 !important; font-weight: 800; border: 1px solid #ffffff !important; box-shadow: 0 4px 16px rgba(255, 255, 255, 0.18); }',
        content
    )
    content = re.sub(
        r'\.button-primary:hover\s*\{[^}]*\}',
        '.button-primary:hover { background: #e5e5e5 !important; color: #000000 !important; transform: translateY(-1px); box-shadow: 0 6px 22px rgba(255, 255, 255, 0.28); }',
        content
    )
    content = re.sub(
        r'\.button-secondary\s*\{[^}]*\}',
        '.button-secondary { background: #141414; color: #ffffff; border: 1px solid #333333; }',
        content
    )
    content = re.sub(
        r'\.button-secondary:hover\s*\{[^}]*\}',
        '.button-secondary:hover { background: #222222; border-color: #ffffff; box-shadow: 0 4px 14px rgba(255, 255, 255, 0.1); }',
        content
    )

    # Site Header (Monochrome Glass)
    content = re.sub(
        r'\.site-header\s*\{[^}]*\}',
        '.site-header { position: fixed; inset: 0 0 auto; z-index: 40; height: 74px; border-bottom: 1px solid #222222; background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); }',
        content
    )

    # Floating Player Dock (High-contrast B&W)
    new_player = '''/* Player - Floating Monochrome Noir Glass Dock */
.music-player {
  position: fixed;
  left: 20px;
  right: 20px;
  bottom: 16px;
  width: calc(100% - 40px);
  max-width: 1400px;
  margin: 0 auto;
  z-index: 60;
  height: 84px;
  display: grid;
  grid-template-columns: minmax(240px, 1fr) minmax(400px, 2fr) minmax(220px, 1fr);
  align-items: center;
  gap: 24px;
  padding: 10px clamp(20px, 3.5vw, 36px);
  border-radius: 20px;
  border: 1px solid #2c2c2c;
  background: rgba(10, 10, 10, 0.94);
  box-shadow:
    0 24px 60px rgba(0, 0, 0, 0.85),
    0 0 1px 1px rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(28px);
  -webkit-backdrop-filter: blur(28px);
  transition: transform 0.24s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.24s ease;
}

.music-player::before {
  content: "";
  position: absolute;
  top: 0;
  left: 24px;
  right: 24px;
  height: 1px;
  background: linear-gradient(90deg, transparent 0%, rgba(255, 255, 255, 0.3) 50%, transparent 100%);
  pointer-events: none;
}

.player-track {
  min-width: 0;
  display: flex;
  align-items: center;
  gap: 13px;
}
.player-track img {
  width: 52px;
  height: 52px;
  flex: 0 0 auto;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.6);
  border: 1px solid #2a2a2a;
}
.player-track > div {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 3px;
}
.player-track a:first-child {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: 700;
  font-size: 13.5px;
  color: #ffffff;
  letter-spacing: -0.01em;
}
.player-track a:first-child:hover {
  text-decoration: underline;
}
.player-track a:last-child {
  color: #a3a3a3;
  font-size: 11px;
  font-weight: 500;
}
.player-track a:last-child:hover {
  color: #ffffff;
}

.player-center {
  min-width: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
}
.player-controls {
  display: flex;
  align-items: center;
  gap: 12px;
}
.player-icon {
  width: 34px;
  height: 34px;
  display: grid;
  place-items: center;
  border: 0;
  border-radius: 50%;
  color: #a3a3a3;
  background: transparent;
  cursor: pointer;
  transition: all 0.18s ease;
}
.player-icon:hover {
  color: #ffffff;
  background: #1c1c1c;
  transform: translateY(-1px);
}
.player-icon svg {
  width: 16px;
  height: 16px;
}
.player-icon--active {
  color: #000000;
  background: #ffffff;
}
.player-icon--active:hover {
  color: #000000;
  background: #e5e5e5;
}

/* Play/Pause Button - High-Contrast Pure White Jewel */
.player-play {
  width: 44px;
  height: 44px;
  display: grid;
  place-items: center;
  margin-inline: 4px;
  border: 0;
  border-radius: 50%;
  color: #000000;
  background: #ffffff;
  box-shadow: 0 4px 18px rgba(255, 255, 255, 0.35);
  cursor: pointer;
  transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
}
.player-play:hover {
  transform: scale(1.08);
  background: #f0f0f0;
  box-shadow: 0 6px 24px rgba(255, 255, 255, 0.5);
}
.player-play svg {
  width: 17px;
  height: 17px;
}

/* Timeline */
.timeline {
  width: min(100%, 540px);
  display: grid;
  grid-template-columns: 36px 1fr 36px;
  align-items: center;
  gap: 10px;
  color: #a3a3a3;
  font-size: 10.5px;
  font-weight: 500;
  font-variant-numeric: tabular-nums;
}
.timeline span:last-child {
  text-align: right;
}

/* Range Sliders Monochrome */
.music-player input[type="range"] {
  --range-progress: 0%;
  height: 4px;
  width: 100%;
  -webkit-appearance: none;
  appearance: none;
  border-radius: 999px;
  background: #262626;
  outline: none;
  cursor: pointer;
  background-image: linear-gradient(90deg, #ffffff 0%, #ffffff 100%);
  background-size: var(--range-progress) 100%;
  background-repeat: no-repeat;
  transition: height 0.14s ease;
}

.music-player input[type="range"]:hover {
  height: 6px;
}

.music-player input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #ffffff;
  border: 2px solid #000000;
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.14s ease, transform 0.14s ease;
}

.music-player input[type="range"]:hover::-webkit-slider-thumb {
  opacity: 1;
  transform: scale(1.15);
}

.music-player input[type="range"]::-moz-range-thumb {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: #ffffff;
  border: 2px solid #000000;
  box-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.14s ease, transform 0.14s ease;
}

.music-player input[type="range"]:hover::-moz-range-thumb {
  opacity: 1;
  transform: scale(1.15);
}'''

    pattern = r'/\* Player - Floating Obsidian Glass Dock.*?(?=\.player-right)'
    content = re.sub(pattern, new_player + '\n\n', content, flags=re.DOTALL)

    # Wave animation in pure white
    content = re.sub(r'\.player-live-wave i\s*\{([^}]*?)background:\s*[^;]+;', r'.player-live-wave i {\1background: #ffffff;', content)

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated styles.css for Monochrome Noir")

def update_redesign_css():
    path = "frontend/src/redesign.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    new_root = ''':root {
  --sw-primary: #ffffff;
  --sw-primary-dark: #e5e5e5;
  --sw-accent: #ffffff;
  --sw-sand: #ffffff;
  --sw-sand-warm: #000000;
  --sw-sand-deep: #ffffff;
  --sw-sand-border: #262626;
  --sw-sand-chip: #171717;
  --sw-bg: #000000;
  --sw-surface: #121212;
  --sw-surface-subtle: #080808;
  --sw-text: #ffffff;
  --sw-text-secondary: #a3a3a3;
  --sw-muted: #737373;
  --sw-border: #262626;
  --sw-danger: #ef4444;
  --sw-danger-dark: #dc2626;
  --sw-danger-light: rgba(239, 68, 68, 0.15);
  --sw-shadow-sm: 0 4px 16px rgba(0, 0, 0, 0.6);
  --sw-shadow-md: 0 12px 36px rgba(0, 0, 0, 0.8);
}'''
    content = re.sub(r':root\s*\{[^}]*\}', new_root, content, count=1)

    # Track card monochrome
    old_card = '''.sw-track-card, .sw-album-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #121626; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease, background .25s ease; }
.sw-track-card:hover, .sw-album-card:hover { transform: translateY(-5px); border-color: rgba(139, 92, 246, 0.45); box-shadow: 0 16px 36px rgba(139, 92, 246, 0.22); background: #161c32; }
.sw-track-card--active { border-color: var(--sw-primary); background: rgba(139, 92, 246, 0.14); box-shadow: 0 0 25px rgba(139, 92, 246, 0.25); }'''

    new_card = '''.sw-track-card, .sw-album-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid #222222; border-radius: 16px; background: #101010; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); transition: transform .22s ease, border-color .22s ease, background .22s ease; }
.sw-track-card:hover, .sw-album-card:hover { transform: translateY(-4px); border-color: #555555; background: #161616; }
.sw-track-card--active { border-color: #ffffff; background: #181818; box-shadow: 0 0 20px rgba(255, 255, 255, 0.12); }'''

    content = content.replace(old_card, new_card)

    # Play button on card: High contrast white circle with black icon
    content = re.sub(
        r'\.sw-track-play\s*\{[^}]*\}',
        '.sw-track-play { position: absolute; right: 10px; bottom: 10px; z-index: 2; width: 42px; height: 42px; display: grid; place-items: center; border-radius: 50%; background: #ffffff; color: #000000; box-shadow: 0 4px 18px rgba(0, 0, 0, 0.7); opacity: 0; transform: translateY(6px); transition: opacity .2s, transform .2s, background .15s; }',
        content
    )
    content = content.replace('.sw-track-card:hover .sw-track-play,', '.sw-track-card:hover .sw-track-play { opacity: 1; transform: translateY(0); }\n.sw-track-card:hover .sw-track-play,')

    # Rank badge: High contrast monochrome pill
    content = re.sub(
        r'\.sw-track-rank\s*\{[^}]*\}',
        '.sw-track-rank { position: absolute; top: 9px; left: 9px; z-index: 2; padding: 4px 8px; border-radius: 8px; background: rgba(0, 0, 0, 0.75); color: #ffffff; border: 1px solid rgba(255, 255, 255, 0.2); font-size: 10px; font-weight: 800; backdrop-filter: blur(8px); }',
        content
    )

    # Playing bars
    content = re.sub(
        r'\.sw-playing-bars\s*\{[^}]*\}',
        '.sw-playing-bars { position: absolute; left: 10px; bottom: 10px; z-index: 2; width: 32px; height: 27px; display: flex; align-items: end; justify-content: center; gap: 3px; padding: 6px; border-radius: 8px; background: rgba(0, 0, 0, 0.85); border: 1px solid rgba(255, 255, 255, 0.2); }',
        content
    )
    content = re.sub(
        r'\.sw-playing-bars i\s*\{([^}]*?)background:\s*[^;]+;',
        r'.sw-playing-bars i {\1background: #ffffff;',
        content
    )

    # Catalog filters
    content = content.replace('background: linear-gradient(135deg, #8b5cf6, #6366f1); border-color: rgba(139, 92, 246, 0.5);', 'background: #ffffff; border-color: #ffffff; color: #000000;')

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated redesign.css for Monochrome Noir")

def update_app_shell():
    path = "frontend/src/app-shell.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # Sidebar: Pure Black #000000
    content = re.sub(
        r'\.app-sidebar\s*\{[^}]*\}',
        '''.app-sidebar {
  width: 240px;
  height: 100vh;
  position: sticky;
  top: 0;
  flex-shrink: 0;
  background: #000000;
  border-right: 1px solid #1c1c1c;
  display: flex;
  flex-direction: column;
  z-index: 40;
  user-select: none;
}''',
        content
    )

    # Active Nav item
    content = re.sub(
        r'\.nav-item--active\s*\{[^}]*\}',
        '''.nav-item--active {
  background: #171717 !important;
  color: #ffffff !important;
  font-weight: 700;
  border-left: 3px solid #ffffff !important;
}''',
        content
    )

    # Topbar
    content = re.sub(
        r'\.app-topbar\s*\{[^}]*\}',
        '''.app-topbar {
  height: 64px;
  position: sticky;
  top: 0;
  z-index: 35;
  background: rgba(0, 0, 0, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid #1c1c1c;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 32px;
  gap: 20px;
}''',
        content
    )

    # Topbar search
    content = re.sub(
        r'\.topbar-search\s*\{[^}]*\}',
        '''.topbar-search {
  position: relative;
  flex: 1;
  max-width: 480px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 40px;
  background: #121212;
  border: 1px solid #282828 !important;
  border-radius: 20px;
  padding: 0 14px;
  color: #ffffff;
  transition: all 0.16s ease;
}
.topbar-search:focus-within {
  background: #181818;
  border-color: #ffffff !important;
  box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.15);
}
.topbar-search input {
  width: 100%;
  border: 0;
  outline: 0;
  background: transparent;
  color: #ffffff;
  font-size: 13px;
}
.topbar-search input::placeholder {
  color: #737373;
}''',
        content
    )

    # Topbar upload button: High contrast white pill
    content = re.sub(
        r'\.topbar-upload-btn\s*\{[^}]*\}',
        '''.topbar-upload-btn {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  height: 38px;
  padding: 0 16px;
  border-radius: 20px;
  border: 1px solid #ffffff !important;
  background: #ffffff;
  color: #000000;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}
.topbar-upload-btn:hover {
  background: #e5e5e5;
  box-shadow: 0 4px 16px rgba(255, 255, 255, 0.25);
  transform: translateY(-1px);
}''',
        content
    )

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated app-shell.css for Monochrome Noir")

def update_dashboard_and_auth():
    # Dashboard
    dpath = "frontend/src/dashboard.css"
    with open(dpath, "r", encoding="utf-8") as f:
        dcontent = f.read()

    new_droot = ''':root {
  --ops-brand: #ffffff;
  --ops-brand-hover: #e5e5e5;
  --ops-brand-light: #262626;
  --ops-brand-border: #404040;
  --ops-bg: #000000;
  --ops-card-bg: #121212;
  --ops-border: #262626;
  --ops-border-subtle: #1c1c1c;
  --ops-text-main: #ffffff;
  --ops-text-secondary: #a3a3a3;
  --ops-text-muted: #737373;

  --ops-green: #10b981;
  --ops-green-dark: #059669;
  --ops-green-light: rgba(16, 185, 129, 0.15);
  --ops-green-border: rgba(16, 185, 129, 0.3);

  --ops-amber: #f59e0b;
  --ops-amber-dark: #d97706;
  --ops-amber-light: rgba(245, 158, 11, 0.15);
  --ops-amber-border: rgba(245, 158, 11, 0.3);

  --ops-red: #ef4444;
  --ops-red-dark: #dc2626;
  --ops-red-light: rgba(239, 68, 68, 0.15);
  --ops-red-border: rgba(239, 68, 68, 0.3);

  --ops-violet: #ffffff;
  --ops-violet-light: #262626;
}'''
    dcontent = re.sub(r':root\s*\{[^}]*\}', new_droot, dcontent, count=1)
    with open(dpath, "w", encoding="utf-8") as f:
        f.write(dcontent)

    # Auth
    apath = "frontend/src/auth-redesign.css"
    with open(apath, "r", encoding="utf-8") as f:
        acontent = f.read()

    acontent = acontent.replace("background: linear-gradient(135deg, #8b5cf6, #6366f1);", "background: #ffffff; color: #000000;")
    acontent = acontent.replace("color: #8b5cf6;", "color: #ffffff;")
    acontent = acontent.replace("border-color: #8b5cf6;", "border-color: #ffffff;")
    acontent = acontent.replace("linear-gradient(145deg, #090b14 0%, #1e1035 50%, #0f172a 100%)", "linear-gradient(145deg, #000000 0%, #0f0f0f 50%, #171717 100%)")
    acontent = acontent.replace("background: linear-gradient(135deg, #8b5cf6, #6366f1);", "background: #ffffff; color: #000000;")

    # Auth Submit button: White pill
    acontent = re.sub(
        r'\.auth-v2-submit\s*\{[^}]*\}',
        '''.auth-v2-submit {
  width: 100%;
  min-height: 49px;
  margin-top: 1px;
  background: #ffffff !important;
  color: #000000 !important;
  font-weight: 800;
  border: 1px solid #ffffff !important;
  box-shadow: 0 4px 18px rgba(255, 255, 255, 0.2);
}
.auth-v2-submit:hover {
  background: #e5e5e5 !important;
  box-shadow: 0 6px 24px rgba(255, 255, 255, 0.3);
}''',
        acontent
    )

    with open(apath, "w", encoding="utf-8") as f:
        f.write(acontent)
    print("Updated dashboard.css and auth-redesign.css for Monochrome Noir")

update_styles()
update_redesign_css()
update_app_shell()
update_dashboard_and_auth()
