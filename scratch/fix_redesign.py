with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    css = f.read()

# 1. Topbar hover in redesign
css = css.replace(
""".topbar-nav-btn:hover, .topbar-icon-btn:hover { color: #000000; background: #202020; border-color: #404040; }""",
""".topbar-nav-btn:hover, .topbar-icon-btn:hover { color: #000000; background: #e4e4e7; border-color: #000000; }"""
)

# 2. discover-hero
css = css.replace(
"""linear-gradient(135deg, #121212 0%, #fff 55%, #121212 100%)""",
"""linear-gradient(135deg, #f4f4f5 0%, #ffffff 55%, #fafafa 100%)"""
)

# 3. sw-track-rank
css = css.replace(
""".sw-track-rank { position: absolute; top: 9px; left: 9px; z-index: 2; padding: 4px 8px; border-radius: 8px; background: rgba(0, 0, 0, 0.75); color: #000000; border: 1px solid rgba(255, 255, 255, 0.2); font-size: 10px; font-weight: 800; backdrop-filter: blur(8px); }""",
""".sw-track-rank { position: absolute; top: 9px; left: 9px; z-index: 2; padding: 4px 8px; border-radius: 8px; background: rgba(0, 0, 0, 0.75); color: #ffffff !important; border: 1px solid rgba(255, 255, 255, 0.2); font-size: 10px; font-weight: 800; backdrop-filter: blur(8px); }"""
)

# 4. track-showcase
css = css.replace(
"""background: linear-gradient(125deg, #141414 0%, #121212 48%, #121212 100%);""",
"""background: linear-gradient(125deg, #fafafa 0%, #ffffff 48%, #f4f4f5 100%); border: 1px solid #e4e4e7; color: #000000;"""
)

# 5. notification and dropdown headers
css = css.replace(
"""background: linear-gradient(135deg, #f0fdff, #fff 65%, #121212);""",
"""background: linear-gradient(135deg, #fafafa, #ffffff 65%, #f4f4f5); border-bottom: 1px solid #e4e4e7; color: #000000;"""
)
css = css.replace(
""".notif-read-all:hover { background: #1f1f1f; }""",
""".notif-read-all:hover { background: #f4f4f5; color: #000000; }"""
)
css = css.replace(
""".notif-item.is-unread:hover { background: #1f1f1f; }""",
""".notif-item.is-unread:hover { background: #f4f4f5; }"""
)
css = css.replace(
"""background: linear-gradient(135deg, #1f1f1f, #fff 64%, #121212);""",
"""background: linear-gradient(135deg, #fafafa, #ffffff 64%, #f4f4f5); border-bottom: 1px solid #e4e4e7; color: #000000;"""
)
css = css.replace(
""".dropdown-item:hover .dropdown-item-icon { background: #1f1f1f; color: var(--sw-primary); }""",
""".dropdown-item:hover .dropdown-item-icon { background: #f4f4f5; color: #000000; }"""
)

# 6. search-hero and search pills
css = css.replace(
"""linear-gradient(135deg, #effdff, #fff 58%, #121212)""",
"""linear-gradient(135deg, #fafafa, #ffffff 58%, #f4f4f5)"""
)
css = css.replace(
""".search-quick-row button:hover { border-color: var(--sw-primary); background: #1f1f1f; color: var(--sw-primary-dark); }""",
""".search-quick-row button:hover { border-color: #000000; background: #f4f4f5; color: #000000; }"""
)
css = css.replace(
""".search-tab-pill > span { min-width: 20px; padding: 2px 5px; border-radius: 5px; background: #1c1c1c; color: #e5e5e5; font-size: 7.5px; }""",
""".search-tab-pill > span { min-width: 20px; padding: 2px 5px; border-radius: 5px; background: #f4f4f5; color: #52525b; font-size: 7.5px; }"""
)
css = css.replace(
""".search-tab-pill:hover { background: #1c1c1c; border-color: var(--sw-sand); color: #5c3a15; }""",
""".search-tab-pill:hover { background: #f4f4f5; border-color: #000000; color: #000000; }"""
)
css = css.replace(
""".search-prompt-icon, .search-empty-icon { width: 56px; height: 56px; display: grid; place-items: center; border-radius: 15px; background: #1f1f1f; color: var(--sw-primary); }""",
""".search-prompt-icon, .search-empty-icon { width: 56px; height: 56px; display: grid; place-items: center; border-radius: 15px; background: #f4f4f5; color: #000000; border: 1px solid #e4e4e7; }"""
)
css = css.replace(
""".search-prompt-state > button:hover { background: #1f1f1f; }""",
""".search-prompt-state > button:hover { background: #f4f4f5; color: #000000; }"""
)

# 7. ms-bento
css = css.replace(
""".ms-btn-details:hover {
  background: #222222;
  border-color: #555555;
}""",
""".ms-btn-details:hover {
  background: #e4e4e7;
  border-color: #000000;
  color: #000000;
}"""
)
css = css.replace(
"""background: linear-gradient(150deg, #121212 0%, #0a0a0a 100%);""",
"""background: linear-gradient(150deg, #fafafa 0%, #ffffff 100%); border: 1px solid #e4e4e7; color: #000000;"""
)
css = css.replace(
""".ms-bento-pulse-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 3px 9px;
  border-radius: 9999px;
  background: #1f1f1f;
  border: 1px solid #333333;
  font-size: 10px;
  font-weight: 700;
  color: #000000;
}""",
""".ms-bento-pulse-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 3px 9px;
  border-radius: 9999px;
  background: #000000;
  border: 1px solid #000000;
  font-size: 10px;
  font-weight: 700;
  color: #ffffff !important;
}"""
)
css = css.replace(
""".ms-bento-metric-cell {
  padding: 16px;
  border-radius: 16px;
  background: #161616;
  border: 1px solid #e4e4e7;
  display: flex;
  flex-direction: column;
  gap: 4px;
}""",
""".ms-bento-metric-cell {
  padding: 16px;
  border-radius: 16px;
  background: #ffffff;
  border: 1px solid #e4e4e7;
  display: flex;
  flex-direction: column;
  gap: 4px;
}"""
)
css = css.replace(
""".ms-bento-pulse-cta:hover {
  background: #222222;
  border-color: #000000;
}""",
""".ms-bento-pulse-cta:hover {
  background: #000000;
  color: #ffffff !important;
  border-color: #000000;
}"""
)

# 8. ms-track-card
css = css.replace(
""".ms-track-card {
  border-radius: 18px;
  border: 1px solid #e5e7eb;
  background: #0f0f0f;
  padding: 12px;
  transition: all 0.22s ease;
  position: relative;
  display: flex;
  flex-direction: column;
}""",
""".ms-track-card {
  border-radius: 18px;
  border: 1px solid #e4e4e7;
  background: #ffffff;
  padding: 12px;
  transition: all 0.22s ease;
  position: relative;
  display: flex;
  flex-direction: column;
}"""
)
css = css.replace(
""".ms-track-card-cover {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 12px;
  background: #1c1c1c;
}""",
""".ms-track-card-cover {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 12px;
  background: #f4f4f5;
}"""
)
css = css.replace(
"""  border-top: 1px solid #1a1a1a;""",
"""  border-top: 1px solid #e4e4e7;"""
)

# 9. ms-leaderboard
css = css.replace(
""".ms-leaderboard-row:hover {
  background: #161616;
  border-color: #2e2e2e;
}""",
""".ms-leaderboard-row:hover {
  background: #f4f4f5;
  border-color: #e4e4e7;
}"""
)
css = css.replace(
""".ms-leaderboard-row.is-active {
  background: #1c1c1c;
  border-color: #404040;
}""",
""".ms-leaderboard-row.is-active {
  background: #f4f4f5;
  border-color: #000000;
}"""
)
css = css.replace(
""".ms-leaderboard-thumb {
  position: relative;
  width: 44px;
  height: 44px;
  border-radius: 9px;
  overflow: hidden;
  flex-shrink: 0;
  background: #1e1e1e;
}""",
""".ms-leaderboard-thumb {
  position: relative;
  width: 44px;
  height: 44px;
  border-radius: 9px;
  overflow: hidden;
  flex-shrink: 0;
  background: #f4f4f5;
}"""
)
css = css.replace(
""".ms-leaderboard-play-btn {
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
}""",
""".ms-leaderboard-play-btn {
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
)
css = css.replace(
""".ms-creator-avatar-wrap {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 50%;
  overflow: hidden;
  margin-bottom: 12px;
  background: #1c1c1c;
}""",
""".ms-creator-avatar-wrap {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 50%;
  overflow: hidden;
  margin-bottom: 12px;
  background: #f4f4f5;
}"""
)

# 10. sp-quick-play and sp-floating-play
css = css.replace(
""".sp-quick-play {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff;""",
""".sp-quick-play {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff !important;"""
)
css = css.replace(
""".sp-quick-play:hover {
  transform: scale(1.06);
  background: #27272a;
}""",
""".sp-quick-play:hover {
  transform: scale(1.06);
  background: #27272a !important;
  color: #ffffff !important;
}
.sp-quick-play svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}"""
)
css = css.replace(
""".sp-floating-play {
  position: absolute;
  right: 10px;
  bottom: 10px;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff;""",
""".sp-floating-play {
  position: absolute;
  right: 10px;
  bottom: 10px;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff !important;"""
)
css = css.replace(
""".sp-floating-play:hover {
  transform: scale(1.08);
  background: #27272a;
}""",
""".sp-floating-play:hover {
  transform: scale(1.08);
  background: #27272a !important;
  color: #ffffff !important;
}
.sp-floating-play svg {
  color: #ffffff !important;
  fill: #ffffff !important;
}"""
)

# 11. sp-genre-card
css = css.replace(
""".sp-genre-card {
  position: relative;
  min-height: 110px;
  border-radius: 8px;
  padding: 16px 14px;
  background: #18181b;
  color: #ffffff;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border: 1px solid #27272a;
  cursor: pointer;
  text-align: left;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.sp-genre-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.sp-genre-title {
  font-size: 15px;
  font-weight: 800;
  letter-spacing: -0.02em;
  color: #ffffff;
}

.sp-genre-desc {
  font-size: 10px;
  color: #a1a1aa;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}""",
""".sp-genre-card {
  position: relative;
  min-height: 110px;
  border-radius: 8px;
  padding: 16px 14px;
  background: #18181b !important;
  color: #ffffff !important;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  border: 1px solid #27272a;
  cursor: pointer;
  text-align: left;
  overflow: hidden;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.sp-genre-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
  border-color: #3f3f46;
}

.sp-genre-title {
  font-size: 15px;
  font-weight: 800;
  letter-spacing: -0.02em;
  color: #ffffff !important;
}

.sp-genre-desc {
  font-size: 10px;
  color: #d4d4d8 !important;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}"""
)

with open(r"frontend/src/redesign.css", "w", encoding="utf-8") as f:
    f.write(css)

print("Updated redesign.css successfully!")
