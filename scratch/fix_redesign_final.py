# Fix redesign.css
with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    css_redesign = f.read()

# 1. ms-bento-spotlight
old_spotlight = """/* Spotlight Card (Large Bento) */
.ms-bento-spotlight {
  padding: 34px 36px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 380px;
  background: radial-gradient(circle at 90% 15%, rgba(255, 255, 255, 0.08) 0%, transparent 60%),
              linear-gradient(135deg, #141414 0%, #0a0a0a 100%);
}"""

new_spotlight = """/* Spotlight Card (Large Bento) */
.ms-bento-spotlight {
  padding: 34px 36px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 380px;
  background: linear-gradient(135deg, #fafafa 0%, #ffffff 100%);
  border: 1px solid #e4e4e7;
  border-radius: 24px;
}"""
css_redesign = css_redesign.replace(old_spotlight, new_spotlight)

# 2. ms-btn-listen
old_listen = """.ms-btn-listen {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 13px 26px;
  border-radius: 9999px;
  background: #ffffff;
  color: #000000;
  font-size: 13px;
  font-weight: 800;
  letter-spacing: -0.01em;
  border: 0;
  cursor: pointer;
  box-shadow: 0 4px 20px rgba(255, 255, 255, 0.2);
  transition: transform 0.18s ease, background 0.18s ease, box-shadow 0.18s ease;
}

.ms-btn-listen:hover {
  transform: translateY(-2px);
  background: #f0f0f0;
  box-shadow: 0 8px 26px rgba(255, 255, 255, 0.3);
}"""

new_listen = """.ms-btn-listen {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 13px 26px;
  border-radius: 9999px;
  background: #000000;
  color: #ffffff !important;
  font-size: 13px;
  font-weight: 800;
  letter-spacing: -0.01em;
  border: 0;
  cursor: pointer;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
  transition: transform 0.18s ease, background 0.18s ease, box-shadow 0.18s ease;
}

.ms-btn-listen svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}

.ms-btn-listen:hover {
  transform: translateY(-2px);
  background: #27272a;
  color: #ffffff !important;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
}"""
css_redesign = css_redesign.replace(old_listen, new_listen)

# 3. ms-leaderboard
old_lb = """.ms-leaderboard-row:hover {
  background: #161616;
  border-color: #282828;
}

.ms-leaderboard-row.is-active {
  background: #1c1c1c;
  border-color: #383838;
}"""

new_lb = """.ms-leaderboard-row:hover {
  background: #f4f4f5;
  border-color: #e4e4e7;
}

.ms-leaderboard-row.is-active {
  background: #f4f4f5;
  border-color: #000000;
}"""
css_redesign = css_redesign.replace(old_lb, new_lb)

css_redesign = css_redesign.replace(
""".ms-leaderboard-thumb {
  width: 44px;
  height: 44px;
  border-radius: 8px;
  overflow: hidden;
  background: #1e1e1e;
  flex-shrink: 0;
}""",
""".ms-leaderboard-thumb {
  width: 44px;
  height: 44px;
  border-radius: 8px;
  overflow: hidden;
  background: #f4f4f5;
  flex-shrink: 0;
}"""
)

old_lb_btn = """.ms-leaderboard-play-btn {
  position: absolute;
  inset: 0;
  background: #1c1c1c;
  color: #000000;
  display: grid;
  place-items: center;
  border: 0;
  opacity: 0;
  cursor: pointer;
  transition: opacity 0.16s ease;
}"""

new_lb_btn = """.ms-leaderboard-play-btn {
  position: absolute;
  inset: 0;
  background: #000000;
  color: #ffffff !important;
  display: grid;
  place-items: center;
  border: 0;
  opacity: 0;
  cursor: pointer;
  transition: opacity 0.16s ease;
}
.ms-leaderboard-play-btn svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}"""
css_redesign = css_redesign.replace(
""".ms-leaderboard-play-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #1c1c1c;
  color: #000000;
  display: grid;
  place-items: center;
  border: 1px solid #333333;
  transition: all 0.18s ease;
}""",
""".ms-leaderboard-play-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff !important;
  display: grid;
  place-items: center;
  border: 1px solid #000000;
  transition: all 0.18s ease;
}
.ms-leaderboard-play-btn svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}"""
)

with open(r"frontend/src/redesign.css", "w", encoding="utf-8") as f:
    f.write(css_redesign)
print("Updated redesign.css final!")

# Now Fix app-shell.css remaining media query topbar and upload notes
with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    css_app = f.read()

# Replace duplicate .app-topbar at line 1033
old_mq_topbar = """  .app-topbar {
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
}"""

new_mq_topbar = """  .app-topbar {
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
}"""
css_app = css_app.replace(old_mq_topbar, new_mq_topbar)

# Fix upload track notes and dark badges
css_app = css_app.replace(
""".upload-track-card-heading > div > span {
  padding: 3px 8px;
  border-radius: 9999px;
  background: #1f1f1f;
  color: var(--sw-primary-dark);
  font-size: 11px;
  font-weight: 700;
}""",
""".upload-track-card-heading > div > span {
  padding: 3px 8px;
  border-radius: 9999px;
  background: #f4f4f5;
  color: #000000;
  border: 1px solid #e4e4e7;
  font-size: 11px;
  font-weight: 700;
}"""
)

css_app = css_app.replace(
""".upload-track-sidebar li svg {
  width: 14px;
  height: 14px;
  padding: 3px;
  border-radius: 50%;
  background: #1f1f1f;
  color: var(--sw-primary-dark);
  flex-shrink: 0;
}""",
""".upload-track-sidebar li svg {
  width: 14px;
  height: 14px;
  padding: 3px;
  border-radius: 50%;
  background: #f4f4f5;
  color: #000000;
  border: 1px solid #e4e4e7;
  flex-shrink: 0;
}"""
)

css_app = css_app.replace(
""".upload-track-sidebar > .upload-track-sidebar__note {
  border-color: rgba(228, 231, 236, 0.2);
  background: #121212;
}""",
""".upload-track-sidebar > .upload-track-sidebar__note {
  border-color: #e4e4e7;
  background: #fafafa;
}"""
)

with open(r"frontend/src/app-shell.css", "w", encoding="utf-8") as f:
    f.write(css_app)
print("Updated app-shell.css remaining items!")
