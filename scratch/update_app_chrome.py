with open("frontend/src/redesign.css", "r", encoding="utf-8") as f:
    text = f.read()

target = """.app-scroll-region::-webkit-scrollbar-thumb { border: 2px solid transparent; border-radius: 10px; background: #404040; background-clip: padding-box; }
.app-sidebar { width: 236px; background: #121212; border-color: #e8dcba; box-shadow: 8px 0 28px rgba(0, 0, 0, .035); }
.music-app-shell--with-player .app-sidebar { height: 100% !important; position: relative; top: auto; overflow: hidden; }
.sidebar-brand { height: 72px; padding-inline: 22px; border-bottom: 1px solid #262626; }
.sidebar-brand .brand-mark { width: 36px; height: 36px; border-radius: 11px; }
.sidebar-brand .brand { font-size: 19px; }
.sidebar-nav { padding: 20px 13px; gap: 26px; overflow: hidden; }
.nav-group-title { padding: 0 12px 8px; font-size: 10px; letter-spacing: .13em; }
.nav-item { min-height: 44px; padding: 10px 13px; border-radius: 12px; font-size: 13px; }
.nav-item:hover { background: #1c1c1c; color: #ffffff; }
.nav-item--active { position: relative; background: linear-gradient(90deg, #1f1f1f, #121212) !important; box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .14); }
.nav-item--active::before { content: ""; position: absolute; left: -1px; width: 3px; height: 22px; border-radius: 0 4px 4px 0; background: var(--sw-primary); }
.sidebar-playlist-cta { padding-inline: 14px; }
.create-playlist-btn { width: 100%; border-style: dashed; }
.sidebar-guest-card { margin: 12px 14px 16px; padding: 14px; border: 1px solid #262626; border-radius: 15px; background: linear-gradient(145deg, #121212, #121212); box-shadow: 0 4px 16px rgba(255, 255, 255, .12); }
.sidebar-guest-card .guest-card-title { margin: 0 0 6px; color: var(--sw-text); font-size: 11px; font-weight: 800; line-height: 1.4; }
.sidebar-guest-card .guest-card-text { margin: 0 0 11px; color: var(--sw-muted); font-size: 9.5px; line-height: 1.55; }
.sidebar-guest-card .button { width: 100%; min-height: 34px; padding-inline: 10px; font-size: 9.5px; }

.app-topbar { height: 72px; padding: 0 32px; background: rgba(253, 250, 244, .92); border-bottom: 1px solid #262626; backdrop-filter: blur(18px); }
.topbar-search { height: 44px; max-width: 520px; border-radius: 13px; background: #fff; border: 1px solid #262626; box-shadow: 0 3px 14px rgba(0, 0, 0, .04); }
.topbar-nav-btn, .topbar-icon-btn { border-radius: 11px; }
.topbar-upload-btn { border-radius: 11px; border: 1px solid #262626 !important; background: rgba(255, 255, 255, 0.15); color: #e5e5e5; }
.topbar-upload-btn:hover { background: #ffffff; color: #fff; border-color: #ffffff !important; box-shadow: 0 4px 14px rgba(255, 255, 255, 0.28); }
.topbar-user-btn { min-height: 42px; border: 1px solid #262626; border-radius: 13px; padding: 4px 9px 4px 5px; background: #141414; }
.app-content-body { max-width: 1450px; padding: 30px 36px 62px; }
.app-shell-footer { margin-top: 10px; }
.app-shell-footer .site-footer { position: relative; display: block; padding-bottom: 0; background: #fff; }"""

replacement = """.app-scroll-region::-webkit-scrollbar-thumb { border: 2px solid transparent; border-radius: 10px; background: #333333; background-clip: padding-box; }
.app-sidebar { width: 236px; background: #000000; border-right: 1px solid #1c1c1c; box-shadow: 8px 0 28px rgba(0, 0, 0, .5); }
.music-app-shell--with-player .app-sidebar { height: 100% !important; position: relative; top: auto; overflow: hidden; }
.sidebar-brand { height: 72px; padding-inline: 22px; border-bottom: 1px solid #1c1c1c; }
.sidebar-brand .brand-mark { width: 36px; height: 36px; border-radius: 11px; }
.sidebar-brand .brand { font-size: 19px; color: #ffffff; }
.sidebar-nav { padding: 20px 13px; gap: 26px; overflow: hidden; }
.nav-group-title { padding: 0 12px 8px; font-size: 10px; letter-spacing: .13em; color: #737373; }
.nav-item { min-height: 44px; padding: 10px 13px; border-radius: 12px; font-size: 13px; color: #a3a3a3; }
.nav-item:hover { background: #141414; color: #ffffff; }
.nav-item--active { position: relative; background: #181818 !important; color: #ffffff !important; box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .15); }
.nav-item--active::before { content: ""; position: absolute; left: -1px; width: 3px; height: 22px; border-radius: 0 4px 4px 0; background: #ffffff; }
.sidebar-playlist-cta { padding-inline: 14px; }
.create-playlist-btn { width: 100%; border: 1px dashed #333333; background: #101010; color: #a3a3a3; }
.create-playlist-btn:hover { border-color: #ffffff; color: #ffffff; background: #181818; }
.sidebar-guest-card { margin: 12px 14px 16px; padding: 14px; border: 1px solid #222222; border-radius: 15px; background: #0d0d0d; box-shadow: 0 4px 16px rgba(0, 0, 0, .5); }
.sidebar-guest-card .guest-card-title { margin: 0 0 6px; color: #ffffff; font-size: 11px; font-weight: 800; line-height: 1.4; }
.sidebar-guest-card .guest-card-text { margin: 0 0 11px; color: #737373; font-size: 9.5px; line-height: 1.55; }
.sidebar-guest-card .button { width: 100%; min-height: 34px; padding-inline: 10px; font-size: 9.5px; }

.app-topbar { height: 72px; padding: 0 32px; background: rgba(0, 0, 0, 0.88); border-bottom: 1px solid #1c1c1c; backdrop-filter: blur(18px); }
.topbar-search { height: 44px; max-width: 520px; border-radius: 13px; background: #121212; border: 1px solid #262626; box-shadow: 0 3px 14px rgba(0, 0, 0, .4); color: #ffffff; }
.topbar-search input { color: #ffffff; background: transparent; }
.topbar-search input::placeholder { color: #737373; }
.topbar-nav-btn, .topbar-icon-btn { border-radius: 11px; color: #a3a3a3; background: #141414; border: 1px solid #262626; }
.topbar-nav-btn:hover, .topbar-icon-btn:hover { color: #ffffff; background: #202020; border-color: #404040; }
.topbar-upload-btn { border-radius: 9999px; border: 1px solid #ffffff !important; background: #ffffff !important; color: #000000 !important; font-weight: 800; }
.topbar-upload-btn:hover { background: #e5e5e5 !important; color: #000000 !important; transform: translateY(-1px); box-shadow: 0 4px 14px rgba(255, 255, 255, 0.25); }
.topbar-user-btn { min-height: 42px; border: 1px solid #262626; border-radius: 13px; padding: 4px 9px 4px 5px; background: #121212; color: #ffffff; }
.app-content-body { max-width: 1450px; padding: 30px 36px 62px; color: #ffffff; }
.app-shell-footer { margin-top: 10px; }
.app-shell-footer .site-footer { position: relative; display: block; padding-bottom: 0; background: #000000; border-top: 1px solid #1c1c1c; color: #a3a3a3; }"""

if target in text:
    text = text.replace(target, replacement)
    with open("frontend/src/redesign.css", "w", encoding="utf-8") as f:
        f.write(text)
    print("Replaced successfully!")
else:
    print("Target not found.")
