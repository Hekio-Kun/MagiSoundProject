import re

path = r"frontend/src/app-shell.css"

with open(path, "r", encoding="utf-8") as f:
    css = f.read()

# 1. music-app-shell color
css = re.sub(
    r'(\.music-app-shell\s*\{[^}]*?)color:\s*#ffffff;',
    r'\1color: #000000;',
    css
)

# 2. sidebar-create-playlist-btn
css = re.sub(
    r'\.sidebar-create-playlist-btn\s*\{([^}]*?)\}',
    r'''.sidebar-create-playlist-btn {
  margin: 4px 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 10px 14px;
  border: 1px dashed #d4d4d8 !important;
  border-radius: 10px;
  background: #ffffff;
  color: #000000;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.16s ease;
}''',
    css
)

css = re.sub(
    r'\.sidebar-create-playlist-btn:hover\s*\{[^}]*?\}',
    r'''.sidebar-create-playlist-btn:hover {
  background: #f4f4f5;
  color: #000000;
  border-color: #000000 !important;
}''',
    css
)

# 3. guest-box-title
css = re.sub(
    r'(\.guest-box-title\s*\{[^}]*?)color:\s*#ffffff;',
    r'\1color: #000000;',
    css
)

# 4. app-topbar and child controls
topbar_block = r'''/* --------------------------------------------------------------------------
   3. AppTopBar Component (Sticky Navigation, Search and Account)
   -------------------------------------------------------------------------- */
.app-topbar {
  height: 64px;
  position: sticky;
  top: 0;
  z-index: 35;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid #e4e4e7;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 32px;
  gap: 20px;
}

.topbar-nav-controls {
  display: flex;
  align-items: center;
  gap: 6px;
}

.topbar-nav-btn {
  width: 32px;
  height: 32px;
  display: grid;
  place-items: center;
  border: 1px solid #e4e4e7 !important;
  border-radius: 50%;
  background: #f4f4f5;
  color: #18181b;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-nav-btn:hover {
  background: #e4e4e7;
  color: #000000;
  border-color: #000000 !important;
}

.topbar-search {
  position: relative;
  flex: 1;
  max-width: 480px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 40px;
  background: #f4f4f5;
  border: 1px solid #e4e4e7 !important;
  border-radius: 20px;
  padding: 0 14px;
  color: #000000;
  transition: all 0.16s ease;
}
.topbar-search:focus-within {
  background: #ffffff;
  border-color: #000000 !important;
  box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.08);
}
.topbar-search svg {
  color: #71717a;
  flex-shrink: 0;
}
.topbar-search input {
  flex: 1;
  width: 100%;
  border: 0 !important;
  outline: none;
  background: transparent;
  color: #000000 !important;
  font-size: 13.5px;
}
.topbar-search input::placeholder {
  color: #71717a;
}

.search-clear-btn {
  border: 0 !important;
  background: none;
  color: #71717a;
  cursor: pointer;
  display: grid;
  place-items: center;
  padding: 2px;
  border-radius: 4px;
}
.search-clear-btn:hover {
  color: #000000;
}

.topbar-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.topbar-upload-btn {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  height: 38px;
  padding: 0 16px;
  border-radius: 20px;
  border: 1px solid #000000 !important;
  background: #000000;
  color: #ffffff !important;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}
.topbar-upload-btn svg {
  color: #ffffff !important;
}
.topbar-upload-btn:hover {
  background: #27272a;
  color: #ffffff !important;
  border-color: #27272a !important;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
  transform: translateY(-1px);
}

.topbar-bell-btn {
  position: relative;
  width: 38px;
  height: 38px;
  display: grid;
  place-items: center;
  border: 1px solid #e4e4e7 !important;
  border-radius: 12px;
  background: #f4f4f5;
  color: #18181b;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-bell-btn:hover {
  background: #e4e4e7;
  color: #000000;
  border-color: #000000 !important;
}'''

# Replace from /* 3. AppTopBar Component to .notification-badge
css = re.sub(
    r'/\*\s*3\.\s*AppTopBar Component.*?(?=\.notification-badge)',
    topbar_block + '\n\n',
    css,
    flags=re.DOTALL
)

# 5. user-display-name and dropdown
css = re.sub(r'(\.user-display-name\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.dropdown-user-name\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.dropdown-item:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000; background: #f4f4f5;', css)
css = re.sub(r'(\.notification-header h3\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.notification-header span\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #52525b;', css)
css = re.sub(r'(\.notification-text\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)

# 6. Queue Drawer
queue_block = r'''.queue-drawer {
  width: 380px;
  max-width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  right: 0;
  background: #ffffff;
  border-left: 1px solid #e4e4e7;
  color: #000000;
  display: flex;
  flex-direction: column;
  z-index: 55;
  box-shadow: -8px 0 32px rgba(0, 0, 0, 0.08);
  transform: translateX(100%);
  visibility: hidden;
  pointer-events: none;
  transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), visibility 0.3s ease, box-shadow 0.3s ease;
}

.queue-drawer--open {
  transform: translateX(0);
  visibility: visible;
  pointer-events: auto;
  box-shadow: -14px 0 42px rgba(0, 0, 0, 0.12);
}

.music-app-shell--with-player .queue-drawer {
  height: 100vh;
}

/* 1. Header and Navigation Tabs */
.queue-drawer-header {
  height: 60px;
  padding: 0 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #e4e4e7;
  background: #ffffff;
  flex-shrink: 0;
}

.queue-drawer-tabs {
  display: flex;
  gap: 6px;
}

.queue-tab {
  padding: 6px 14px;
  border: 0 !important;
  border-radius: 9px;
  background: #f4f4f5;
  font-size: 12.5px;
  font-weight: 600;
  color: #52525b;
  cursor: pointer;
  transition: all 0.16s ease;
}

.queue-tab:hover {
  background: #e4e4e7;
  color: #000000;
}

.queue-tab--active {
  background: #000000 !important;
  color: #ffffff !important;
  font-weight: 700;
  box-shadow: none;
}

.queue-close-btn {
  width: 34px;
  height: 34px;
  border: 0 !important;
  border-radius: 9px;
  background: transparent;
  color: #71717a;
  display: grid;
  place-items: center;
  cursor: pointer;
  transition: all 0.16s ease;
}

.queue-close-btn:hover {
  background: #f4f4f5;
  color: #000000;
}

/* 2. Scrollable Body */
.queue-drawer-body {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 16px 16px 110px 16px;
  display: flex;
  flex-direction: column;
  gap: 20px;
  overscroll-behavior: contain;
}

.queue-drawer-body::-webkit-scrollbar {
  width: 6px;
}
.queue-drawer-body::-webkit-scrollbar-track {
  background: transparent;
}
.queue-drawer-body::-webkit-scrollbar-thumb {
  background: #e4e4e7;
  border-radius: 8px;
}

/* 3. Section Labels */
.queue-section-label {
  font-size: 10px;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  color: #71717a;
  margin: 0;
}

/* 4. Now Playing Hero Card */
.queue-now-playing {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.queue-track-card {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 10px;
  border-radius: 12px;
  background: transparent;
  border: 1px solid transparent;
  transition: all 0.16s ease;
  user-select: none;
}

.queue-track-card:hover {
  background: #f4f4f5;
  border-color: #e4e4e7;
}

.queue-track-card--active {
  padding: 12px;
  border-radius: 14px;
  background: #f4f4f5;
  border: 1px solid #000000;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.queue-track-card--dragging {
  opacity: 0.45;
  border: 1.5px dashed #000000;
  background: #f4f4f5;
}'''

css = re.sub(
    r'\.queue-drawer\s*\{.*?(?=\/\*\s*5\.\s*Track Cover Thumbnail)',
    queue_block + '\n\n',
    css,
    flags=re.DOTALL
)

css = re.sub(
    r'(\.queue-track-card--active \.queue-track-title\s*\{[^}]*?)color:\s*#ffffff;',
    r'\1color: #000000; font-weight: 800;',
    css
)

# 7. Section titles & music cards
css = re.sub(r'(\.section-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(
    r'\.music-card-play-btn\s*\{[^}]*?\}',
    r'''.music-card-play-btn {
  position: absolute;
  right: 12px;
  bottom: 12px;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff !important;
  display: grid;
  place-items: center;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.25);
  border: 0;
  cursor: pointer;
  opacity: 0;
  transform: translateY(8px);
  transition: all 0.2s ease;
}
.music-card-play-btn svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}''',
    css
)
css = re.sub(r'(\.music-card-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.music-card-title:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000; text-decoration: underline;', css)
css = re.sub(r'(\.music-card-creator:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)

# 8. Table track row
css = re.sub(r'(\.table-track-row:hover\s*\{[^}]*?)background:\s*#f8fafc;', r'\1background: #fafafa;', css)
css = re.sub(r'\.table-track-row--active\s*\{[^}]*?\}', r'''.table-track-row--active {
  background: #f4f4f5 !important;
  border-left: 3px solid #000000 !important;
}''', css)
css = re.sub(r'(\.row-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.row-title:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000; text-decoration: underline;', css)
css = re.sub(r'(\.row-creator:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.row-album-name a:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.row-icon-btn:hover\s*\{[^}]*?)color:\s*#ffffff;\s*background:\s*#f2f4f7;', r'\1color: #000000; background: #f4f4f5;', css)

# 9. Filter pills
css = re.sub(
    r'\.filter-pill\s*\{([^}]*?)\}',
    r'''.filter-pill {
  padding: 6px 14px;
  border-radius: 9999px;
  border: 1px solid #e4e4e7;
  background: #f4f4f5;
  color: #52525b;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.16s ease;
}''',
    css
)
css = re.sub(
    r'\.filter-pill:hover\s*\{[^}]*?\}',
    r'''.filter-pill:hover {
  background: #e4e4e7;
  color: #000000;
  border-color: #000000;
}''',
    css
)
css = re.sub(
    r'\.filter-pill--active\s*\{[^}]*?\}',
    r'''.filter-pill--active {
  background: #000000 !important;
  border-color: #000000 !important;
  color: #ffffff !important;
}''',
    css
)

# 10. Search inputs and tabs
css = re.sub(r'(\.search-big-input\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000 !important; border: 1px solid #e4e4e7;', css)
css = re.sub(r'(\.search-big-input:focus\s*\{[^}]*?)border-color:\s*#ffffff;', r'\1border-color: #000000; box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.08);', css)
css = re.sub(r'(\.search-tab:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'\.search-tab--active\s*\{[^}]*?\}', r'''.search-tab--active {
  background: #000000 !important;
  color: #ffffff !important;
}''', css)

# 11. Page titles and lyrics
css = re.sub(r'(\.page-heading\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.track-page-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.lyrics-card-header h2\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.album-title,\s*\.creator-profile-name\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.creator-card-name\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.empty-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.playlist-card-title\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.metric-value\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.library-tab:hover\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)

# 12. Form inputs and modals
css = re.sub(r'(\.form-group input,\s*\.form-group select,\s*\.form-group textarea\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000 !important; border: 1px solid #e4e4e7;', css)
css = re.sub(r'(\.form-group input:focus,\s*\.form-group select:focus,\s*\.form-group textarea:focus\s*\{[^}]*?)border-color:\s*#ffffff;', r'\1border-color: #000000; box-shadow: 0 0 0 3px rgba(0,0,0,0.06);', css)
css = re.sub(r'(\.modal-header h2,\s*\.modal-header h3,\s*\.dialog-header h2,\s*\.dialog-header h3\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)

# 13. Drop zone & studio upload
css = re.sub(r'(\.file-drop-zone\s*\{[^}]*?)', r'\1', css)
css = re.sub(r'\.file-drop-zone:hover\s*\{[^}]*?\}', r'''.file-drop-zone:hover {
  background: #f4f4f5;
  border-color: #000000;
}''', css)
css = re.sub(r'(\.file-drop-label svg\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.studio-upload-field__icon\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.studio-upload-field__copy strong\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.studio-upload-progress small\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #52525b;', css)

# 14. Profile settings
css = re.sub(r'(\.profile-settings-hero \.eyebrow\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #71717a;', css)
css = re.sub(r'(\.profile-settings-hero h1\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.profile-section-kicker\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #71717a;', css)
css = re.sub(r'(\.profile-about-card h2,\s*\.profile-card-heading h2\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.profile-settings-heading h2\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.profile-details-card dd\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.profile-avatar-editor strong\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000;', css)
css = re.sub(r'(\.profile-form-field input,\s*\.profile-form-field textarea\s*\{[^}]*?)color:\s*#ffffff;', r'\1color: #000000 !important; border: 1px solid #e4e4e7;', css)
css = re.sub(r'(\.profile-form-field input:focus,\s*\.profile-form-field textarea:focus\s*\{[^}]*?)border-color:\s*#ffffff;', r'\1border-color: #000000; box-shadow: 0 0 0 3px rgba(0,0,0,0.06);', css)

with open(path, "w", encoding="utf-8") as f:
    f.write(css)

print("Updated app-shell.css successfully!")
