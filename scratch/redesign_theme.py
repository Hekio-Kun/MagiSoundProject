import re
import os

def update_styles_css():
    path = "frontend/src/styles.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Update font import
    content = re.sub(
        r'@import url\("https://fonts\.googleapis\.com/css2\?family=Be\+Vietnam\+Pro[^"]*"\);',
        '@import url("https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap");',
        content
    )

    # 2. Update :root
    root_pattern = r':root\s*\{[^}]*\}'
    new_root = ''':root {
  font-family: "Plus Jakarta Sans", Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: #f8fafc;
  background: #090b14;
  font-synthesis: none;
  text-rendering: optimizeLegibility;

  /* Brand Magic Violet & Electric Cyan Palette */
  --brand: #8b5cf6;
  --brand-dark: #7c3aed;
  --brand-light: rgba(139, 92, 246, 0.15);
  --brand-glow: rgba(139, 92, 246, 0.35);

  --accent-cyan: #06b6d4;
  --accent-emerald: #10b981;
  --accent-glow: rgba(6, 182, 212, 0.35);

  /* Deep Space Surfaces (Obsidian & Midnight) */
  --ms-bg: #090b14;
  --ms-surface-0: #0d111d;
  --ms-surface-1: #131828;
  --ms-surface-2: #1b2238;
  --ms-surface-3: #242d4a;
  --ms-border: rgba(255, 255, 255, 0.08);
  --ms-border-hover: rgba(139, 92, 246, 0.4);

  /* Legacy variable mappings remapped to new Dark Luxury Theme */
  --sand: #8b5cf6;
  --sand-warm: #090b14;
  --sand-deep: #a78bfa;
  --sand-chip: #191c2e;
  --text: #f8fafc;
  --muted: #94a3b8;
  --line: rgba(255, 255, 255, 0.08);
  --surface: #131828;
  --container: 1280px;

  --sw-bg: #090b14;
  --sw-surface: #131828;
  --sw-surface-subtle: #0f1424;
  --sw-border: rgba(255, 255, 255, 0.08);
  --sw-border-hover: rgba(139, 92, 246, 0.4);
  --sw-text-primary: #f8fafc;
  --sw-text-secondary: #94a3b8;
  --sw-text-muted: #64748b;
  --sw-brand: #8b5cf6;
  --sw-brand-dark: #7c3aed;
  --sw-brand-light: rgba(139, 92, 246, 0.15);

  --sw-danger: #f43f5e;
  --sw-danger-dark: #e11d48;
  --sw-danger-light: rgba(244, 63, 94, 0.15);
  --sw-success: #10b981;
  --sw-warning: #f59e0b;
}'''
    content = re.sub(root_pattern, new_root, content, count=1)

    # 3. Update body background
    content = re.sub(r'body\s*\{[^}]*\}', 'body { margin: 0; min-width: 320px; min-height: 100vh; background: #090b14; color: #f8fafc; }', content)

    # 4. Update Header glass & brand
    content = re.sub(
        r'\.site-header\s*\{[^}]*\}',
        '.site-header { position: fixed; inset: 0 0 auto; z-index: 40; height: 76px; border-bottom: 1px solid rgba(255, 255, 255, 0.08); background: rgba(9, 11, 20, 0.85); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); }',
        content
    )
    content = re.sub(r'\.brand\s*\{([^}]*?)color:\s*#1c1917;', r'.brand {\1color: #f8fafc;', content)

    # 5. Update header search
    content = re.sub(
        r'\.header-search\s*\{[^}]*\}',
        '.header-search { justify-self: center; width: min(100%, 430px); height: 44px; display: flex; align-items: center; gap: 10px; padding: 0 14px; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 13px; background: #131828; color: #94a3b8; transition: background .18s, border .18s, box-shadow .18s; }',
        content
    )
    content = re.sub(
        r'\.header-search:focus-within\s*\{[^}]*\}',
        '.header-search:focus-within { background: #181f34; border-color: var(--brand); box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.2); }',
        content
    )
    content = re.sub(
        r'\.header-search input\s*\{[^}]*\}',
        '.header-search input { width: 100%; border: 0; outline: 0; background: transparent; color: #f8fafc; font-size: 13px; }',
        content
    )
    content = re.sub(
        r'\.header-search input::placeholder\s*\{[^}]*\}',
        '.header-search input::placeholder { color: #64748b; }',
        content
    )

    # 6. Buttons
    content = re.sub(
        r'\.button-primary\s*\{[^}]*\}',
        '.button-primary { background: linear-gradient(135deg, #8b5cf6, #6366f1); color: #fff; box-shadow: 0 8px 24px rgba(139, 92, 246, 0.35); border: 1px solid rgba(255, 255, 255, 0.15); }',
        content
    )
    content = re.sub(
        r'\.button-primary:hover\s*\{[^}]*\}',
        '.button-primary:hover { background: linear-gradient(135deg, #7c3aed, #4f46e5); box-shadow: 0 12px 30px rgba(139, 92, 246, 0.5); transform: translateY(-1px); }',
        content
    )
    content = re.sub(
        r'\.button-secondary\s*\{[^}]*\}',
        '.button-secondary { background: #131828; color: #f8fafc; border: 1px solid rgba(255, 255, 255, 0.1); }',
        content
    )
    content = re.sub(
        r'\.button-secondary:hover\s*\{[^}]*\}',
        '.button-secondary:hover { border-color: var(--brand); background: #1b2238; box-shadow: 0 8px 20px rgba(139, 92, 246, 0.2); }',
        content
    )
    content = re.sub(
        r'\.button-ghost\s*\{[^}]*\}',
        '.button-ghost { background: transparent; color: #94a3b8; }',
        content
    )
    content = re.sub(
        r'\.button-ghost:hover\s*\{[^}]*\}',
        '.button-ghost:hover { background: #181f34; color: #f8fafc; }',
        content
    )

    # 7. Navigation links
    content = re.sub(
        r'\.main-nav a\s*\{([^}]*?)color:\s*#57534e;',
        r'.main-nav a {\1color: #94a3b8;',
        content
    )
    content = re.sub(
        r'\.main-nav a:hover,\s*\.main-nav \.nav-active\s*\{[^}]*\}',
        '.main-nav a:hover, .main-nav .nav-active { color: #f8fafc; }',
        content
    )

    # 8. Profile button
    content = re.sub(
        r'\.profile-button\s*\{[^}]*\}',
        '.profile-button { height: 44px; display: flex; align-items: center; gap: 9px; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 13px; padding: 4px 12px 4px 5px; background: #131828; color: #f8fafc; transition: all .2s; }',
        content
    )
    content = re.sub(
        r'\.profile-button span\s*\{[^}]*\}',
        '.profile-button span { width: 34px; height: 34px; display: grid; place-items: center; border-radius: 10px; background: rgba(139, 92, 246, 0.2); color: #c4b5fd; font-weight: 800; font-size: 12px; }',
        content
    )

    # 9. Track cards & surface cards in styles.css
    content = re.sub(
        r'\.track-card\s*\{[^}]*\}',
        '.track-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #131828; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }',
        content
    )
    content = re.sub(
        r'\.track-card:hover\s*\{[^}]*\}',
        '.track-card:hover { transform: translateY(-5px); border-color: rgba(139, 92, 246, 0.5); box-shadow: 0 16px 36px rgba(139, 92, 246, 0.2); background: #161c30; }',
        content
    )
    content = re.sub(
        r'\.track-card--active\s*\{[^}]*\}',
        '.track-card--active { border-color: var(--brand); background: rgba(139, 92, 246, 0.12); box-shadow: 0 0 25px rgba(139, 92, 246, 0.25); }',
        content
    )

    # Hero section in styles.css
    content = re.sub(
        r'\.hero h1\s*\{([^}]*?)color:\s*#101828;',
        r'.hero h1 {\1color: #f8fafc;',
        content
    )
    content = re.sub(
        r'\.hero-copy > p\s*\{([^}]*?)color:\s*#667085;',
        r'.hero-copy > p {\1color: #94a3b8;',
        content
    )
    content = re.sub(
        r'\.hero-visual::before\s*\{[^}]*\}',
        '.hero-visual::before { content: ""; position: absolute; width: 480px; height: 420px; right: 15px; top: 43px; z-index: -2; border-radius: 45% 55% 57% 43%; background: radial-gradient(circle, rgba(139, 92, 246, 0.28) 0%, rgba(6, 182, 212, 0.15) 50%, transparent 70%); filter: blur(40px); transform: rotate(-6deg); }',
        content
    )
    content = re.sub(
        r'\.hero-orbit-two\s*\{[^}]*\}',
        '.hero-orbit-two { width: 315px; height: 315px; right: 99px; top: 97px; border-color: rgba(139, 92, 246, 0.2); }',
        content
    )
    content = re.sub(
        r'\.hero-cover\s*\{[^}]*\}',
        '.hero-cover { position: absolute; object-fit: cover; border: 4px solid rgba(255, 255, 255, 0.15); border-radius: 24px; box-shadow: 0 28px 60px rgba(0, 0, 0, 0.6); }',
        content
    )
    content = re.sub(
        r'\.hero-mini-player\s*\{[^}]*\}',
        '.hero-mini-player { position: absolute; width: 358px; right: 49px; bottom: 17px; z-index: 5; padding: 15px 17px 14px; border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 18px; background: rgba(19, 24, 40, 0.88); box-shadow: 0 24px 55px rgba(0, 0, 0, 0.5); backdrop-filter: blur(20px); }',
        content
    )

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated styles.css")

update_styles_css()
