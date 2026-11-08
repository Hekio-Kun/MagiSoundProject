import re

def transform_app_shell():
    path = "frontend/src/app-shell.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Backgrounds & Core layout
    content = content.replace("background-color: var(--sw-bg, #f6efe3);", "background-color: var(--ms-bg, #090b14);")
    content = content.replace("background: #fdfaf4;", "background: rgba(13, 17, 29, 0.95);")
    content = content.replace("border-right: 1px solid #e8dcba;", "border-right: 1px solid rgba(255, 255, 255, 0.07);")
    
    # 2. Sidebar brand & nav
    content = re.sub(r'\.sidebar-brand\s*\{[^}]*\}', '''.sidebar-brand {
  height: 64px;
  padding: 0 20px;
  display: flex;
  align-items: center;
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
}''', content)

    content = re.sub(r'\.sidebar-brand \.brand\s*\{([^}]*?)color:\s*#101828;', r'.sidebar-brand .brand {\1color: #f8fafc;', content)
    
    # Nav items
    content = re.sub(r'\.nav-group-title\s*\{[^}]*\}', '''.nav-group-title {
  padding: 0 12px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.08em;
  color: #64748b;
  margin-bottom: 8px;
  display: block;
}''', content)

    content = re.sub(r'\.nav-item\s*\{[^}]*\}', '''.nav-item {
  width: 100%;
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 14px;
  border: 0 !important;
  border-radius: 12px;
  background: transparent;
  color: #94a3b8;
  font-size: 13.5px;
  font-weight: 600;
  cursor: pointer;
  text-align: left;
  transition: all 0.2s ease;
}''', content)

    content = re.sub(r'\.nav-item:hover\s*\{[^}]*\}', '''.nav-item:hover {
  background: rgba(255, 255, 255, 0.06);
  color: #f8fafc;
}''', content)

    content = re.sub(r'\.nav-item--active\s*\{[^}]*\}', '''.nav-item--active {
  background: linear-gradient(90deg, rgba(139, 92, 246, 0.22), rgba(6, 182, 212, 0.08)) !important;
  color: #c4b5fd !important;
  font-weight: 700;
  border-left: 3px solid #8b5cf6 !important;
  box-shadow: inset 0 0 20px rgba(139, 92, 246, 0.12);
}''', content)

    # 3. TopBar
    content = re.sub(r'\.app-topbar\s*\{[^}]*\}', '''.app-topbar {
  height: 64px;
  position: sticky;
  top: 0;
  z-index: 35;
  background: rgba(9, 11, 20, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(255, 255, 255, 0.07);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 32px;
  gap: 20px;
}''', content)

    content = re.sub(r'\.topbar-nav-btn\s*\{[^}]*\}', '''.topbar-nav-btn {
  width: 32px;
  height: 32px;
  display: grid;
  place-items: center;
  border: 1px solid rgba(255, 255, 255, 0.08) !important;
  border-radius: 50%;
  background: #131828;
  color: #94a3b8;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-nav-btn:hover {
  background: #1e263d;
  color: #f8fafc;
  border-color: rgba(139, 92, 246, 0.3) !important;
}''', content)

    content = re.sub(r'\.topbar-search\s*\{[^}]*\}', '''.topbar-search {
  position: relative;
  flex: 1;
  max-width: 480px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 40px;
  background: #131828;
  border: 1px solid rgba(255, 255, 255, 0.08) !important;
  border-radius: 20px;
  padding: 0 14px;
  color: #94a3b8;
  transition: all 0.16s ease;
}
.topbar-search:focus-within {
  background: #181f34;
  border-color: var(--brand) !important;
  box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
}
.topbar-search input {
  width: 100%;
  border: 0;
  outline: 0;
  background: transparent;
  color: #f8fafc;
  font-size: 13px;
}
.topbar-search input::placeholder {
  color: #64748b;
}''', content)

    content = re.sub(r'\.topbar-upload-btn\s*\{[^}]*\}', '''.topbar-upload-btn {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  height: 38px;
  padding: 0 16px;
  border-radius: 12px;
  border: 1px solid rgba(139, 92, 246, 0.3) !important;
  background: rgba(139, 92, 246, 0.15);
  color: #c4b5fd;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}
.topbar-upload-btn:hover {
  background: linear-gradient(135deg, #8b5cf6, #6366f1);
  color: #fff;
  box-shadow: 0 6px 20px rgba(139, 92, 246, 0.4);
}''', content)

    content = re.sub(r'\.topbar-bell-btn\s*\{[^}]*\}', '''.topbar-bell-btn {
  position: relative;
  width: 38px;
  height: 38px;
  display: grid;
  place-items: center;
  border: 1px solid rgba(255, 255, 255, 0.08) !important;
  border-radius: 12px;
  background: #131828;
  color: #94a3b8;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-bell-btn:hover {
  background: #1e263d;
  color: #f8fafc;
  border-color: rgba(139, 92, 246, 0.3) !important;
}''', content)

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Transformed app-shell.css")

def transform_redesign():
    path = "frontend/src/redesign.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    new_root = ''':root {
  --sw-primary: #8b5cf6;
  --sw-primary-dark: #7c3aed;
  --sw-accent: #06b6d4;
  --sw-sand: #8b5cf6;
  --sw-sand-warm: #090b14;
  --sw-sand-deep: #c4b5fd;
  --sw-sand-border: rgba(255, 255, 255, 0.08);
  --sw-sand-chip: #191e33;
  --sw-bg: #090b14;
  --sw-surface: #121626;
  --sw-surface-subtle: #0d101d;
  --sw-text: #f8fafc;
  --sw-text-secondary: #94a3b8;
  --sw-muted: #64748b;
  --sw-border: rgba(255, 255, 255, 0.08);
  --sw-danger: #f43f5e;
  --sw-danger-dark: #e11d48;
  --sw-danger-light: rgba(244, 63, 94, 0.15);
  --sw-shadow-sm: 0 8px 24px rgba(0, 0, 0, 0.35);
  --sw-shadow-md: 0 18px 48px rgba(0, 0, 0, 0.5);
}'''
    content = re.sub(r':root\s*\{[^}]*\}', new_root, content, count=1)

    # Replace hardcoded old styles
    content = content.replace("background: #fdfaf4;", "background: #121626;")
    content = content.replace("background: #fbf3e5;", "background: rgba(139, 92, 246, 0.15);")
    content = content.replace("color: #8c5828;", "color: #c4b5fd;")
    content = content.replace("border: 1px solid #ebd8be;", "border: 1px solid rgba(139, 92, 246, 0.3);")
    content = content.replace("background: #fdf7ee;", "background: #181f34;")
    content = content.replace("background: #fdf5e8;", "background: rgba(139, 92, 246, 0.15);")
    content = content.replace("background: #d4a373;", "background: #8b5cf6;")

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Transformed redesign.css")

def transform_dashboard():
    path = "frontend/src/dashboard.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    new_root = ''':root {
  --ops-brand: #8b5cf6;
  --ops-brand-hover: #7c3aed;
  --ops-brand-light: rgba(139, 92, 246, 0.15);
  --ops-brand-border: rgba(139, 92, 246, 0.3);
  --ops-bg: #090b14;
  --ops-card-bg: #121626;
  --ops-border: rgba(255, 255, 255, 0.08);
  --ops-border-subtle: rgba(255, 255, 255, 0.04);
  --ops-text-main: #f8fafc;
  --ops-text-secondary: #94a3b8;
  --ops-text-muted: #64748b;

  --ops-green: #10b981;
  --ops-green-dark: #059669;
  --ops-green-light: rgba(16, 185, 129, 0.15);
  --ops-green-border: rgba(16, 185, 129, 0.3);

  --ops-amber: #f59e0b;
  --ops-amber-dark: #d97706;
  --ops-amber-light: rgba(245, 158, 11, 0.15);
  --ops-amber-border: rgba(245, 158, 11, 0.3);

  --ops-red: #f43f5e;
  --ops-red-dark: #e11d48;
  --ops-red-light: rgba(244, 63, 94, 0.15);
  --ops-red-border: rgba(244, 63, 94, 0.3);

  --ops-violet: #8b5cf6;
  --ops-violet-light: rgba(139, 92, 246, 0.15);
}'''
    content = re.sub(r':root\s*\{[^}]*\}', new_root, content, count=1)
    
    # Tables and cards
    content = content.replace("background: #f8fafc;", "background: #090b14;")
    content = content.replace("background-color: #f8fafc;", "background-color: #090b14;")
    content = content.replace("background: #ffffff;", "background: #121626;")
    content = content.replace("background-color: #ffffff;", "background-color: #121626;")

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Transformed dashboard.css")

def transform_auth():
    path = "frontend/src/auth-redesign.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    content = content.replace("background: #fff;\n  color: var(--sw-text, #101828);", "background: #090b14;\n  color: #f8fafc;")
    content = content.replace("linear-gradient(145deg, #072b3f 0%, #07566e 52%, #0369a1 100%)", "linear-gradient(145deg, #090b14 0%, #1e1035 50%, #0f172a 100%)")
    content = content.replace("radial-gradient(circle at 14% 12%, rgba(103, 232, 249, .16), transparent 25%)", "radial-gradient(circle at 14% 12%, rgba(139, 92, 246, .3), transparent 30%)")
    content = content.replace("radial-gradient(circle at 93% 90%, rgba(212, 163, 115, .32), transparent 34%)", "radial-gradient(circle at 93% 90%, rgba(6, 182, 212, .25), transparent 34%)")
    
    # Workspace & Card
    content = re.sub(r'\.auth-v2-workspace\s*\{[^}]*\}', '''.auth-v2-workspace {
  position: relative;
  display: grid;
  place-items: center;
  min-height: 100dvh;
  padding: 76px clamp(34px, 6vw, 88px) 50px;
  background: radial-gradient(circle at 100% 0, rgba(139, 92, 246, 0.12) 0, transparent 30%), #090b14;
}''', content)

    content = re.sub(r'\.auth-v2-tabs\s*\{[^}]*\}', '''.auth-v2-tabs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 5px;
  margin-bottom: 27px;
  padding: 5px;
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 13px;
  background: #121626;
}''', content)

    content = re.sub(r'\.auth-v2-tabs button\.is-active\s*\{[^}]*\}', '''.auth-v2-tabs button.is-active {
  background: linear-gradient(135deg, #8b5cf6, #6366f1);
  color: #fff;
  box-shadow: 0 4px 16px rgba(139, 92, 246, 0.4);
}''', content)

    content = re.sub(r'\.auth-v2-heading h1\s*\{([^}]*?)color:\s*#101828;', r'.auth-v2-heading h1 {\1color: #f8fafc;', content)
    content = re.sub(r'\.auth-v2-heading > span\s*\{([^}]*?)color:\s*#0284c7;', r'.auth-v2-heading > span {\1color: #8b5cf6;', content)
    content = re.sub(r'\.auth-v2-field > label,\s*\.auth-v2-label-row label\s*\{[^}]*\}', '.auth-v2-field > label, .auth-v2-label-row label { color: #cbd5e1; font-size: 10px; font-weight: 700; }', content)

    content = re.sub(r'\.auth-v2-input\s*\{[^}]*\}', '''.auth-v2-input {
  height: 48px;
  display: grid;
  grid-template-columns: 36px minmax(0, 1fr);
  align-items: center;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  background: #121626;
  color: #f8fafc;
  transition: border-color .15s, box-shadow .15s;
}
.auth-v2-input:focus-within {
  border-color: #8b5cf6;
  box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.25);
  background: #181d32;
}
.auth-v2-input input {
  color: #f8fafc;
}''', content)

    content = re.sub(r'\.auth-v2-submit\s*\{[^}]*\}', '''.auth-v2-submit {
  width: 100%;
  min-height: 49px;
  margin-top: 1px;
  background: linear-gradient(135deg, #8b5cf6, #6366f1);
  color: #fff;
  border: 1px solid rgba(255, 255, 255, 0.15);
  box-shadow: 0 9px 24px rgba(139, 92, 246, 0.4);
}
.auth-v2-submit:hover {
  background: linear-gradient(135deg, #7c3aed, #4f46e5);
  box-shadow: 0 12px 30px rgba(139, 92, 246, 0.55);
}''', content)

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Transformed auth-redesign.css")

transform_app_shell()
transform_redesign()
transform_dashboard()
transform_auth()
