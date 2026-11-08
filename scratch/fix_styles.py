with open(r"frontend/src/styles.css", "r", encoding="utf-8") as f:
    css = f.read()

# 1. Site header
css = css.replace(
""".site-header { position: fixed; inset: 0 0 auto; z-index: 40; height: 74px; border-bottom: 1px solid #222222; background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); }""",
""".site-header { position: fixed; inset: 0 0 auto; z-index: 40; height: 74px; border-bottom: 1px solid #e4e4e7; background: rgba(255, 255, 255, 0.92); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); }"""
)

# 2. Header search
css = css.replace(
""".header-search { justify-self: center; width: min(100%, 430px); height: 44px; display: flex; align-items: center; gap: 10px; padding: 0 14px; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 13px; background: #131828; color: #94a3b8; transition: background .18s, border .18s, box-shadow .18s; }
.header-search:focus-within { background: #181818; border-color: var(--brand); box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2); }
.header-search input { width: 100%; border: 0; outline: 0; background: transparent; color: #f8fafc; font-size: 13px; }
.header-search input::placeholder { color: #64748b; }""",
""".header-search { justify-self: center; width: min(100%, 430px); height: 44px; display: flex; align-items: center; gap: 10px; padding: 0 14px; border: 1px solid #e4e4e7; border-radius: 13px; background: #f4f4f5; color: #000000; transition: background .18s, border .18s, box-shadow .18s; }
.header-search:focus-within { background: #ffffff; border-color: #000000; box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.08); }
.header-search input { width: 100%; border: 0; outline: 0; background: transparent; color: #000000 !important; font-size: 13px; }
.header-search input::placeholder { color: #71717a; }"""
)

# 3. Profile button
css = css.replace(
""".profile-button { height: 44px; display: flex; align-items: center; gap: 9px; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 13px; padding: 4px 12px 4px 5px; background: #131828; color: #f8fafc; transition: all .2s; }
.profile-button span { width: 34px; height: 34px; display: grid; place-items: center; border-radius: 10px; background: rgba(255, 255, 255, 0.2); color: #e5e5e5; font-weight: 800; font-size: 12px; }""",
""".profile-button { height: 44px; display: flex; align-items: center; gap: 9px; border: 1px solid #e4e4e7; border-radius: 13px; padding: 4px 12px 4px 5px; background: #f4f4f5; color: #18181b; transition: all .2s; }
.profile-button span { width: 34px; height: 34px; display: grid; place-items: center; border-radius: 10px; background: #e4e4e7; color: #000000; font-weight: 800; font-size: 12px; }"""
)

# 4. Hero kicker
css = css.replace(
""".hero-kicker { width: fit-content; display: flex; align-items: center; gap: 10px; margin-bottom: 22px; padding: 7px 11px; border: 1px solid #cffafe; border-radius: 999px; color: #ffffff; background: #1f1f1f; font-size: 11px; font-weight: 700; letter-spacing: .035em; }""",
""".hero-kicker { width: fit-content; display: flex; align-items: center; gap: 10px; margin-bottom: 22px; padding: 7px 11px; border: 1px solid #e4e4e7; border-radius: 999px; color: #000000; background: #f4f4f5; font-size: 11px; font-weight: 700; letter-spacing: .035em; }"""
)

# 5. Track card
css = css.replace(
""".track-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #131828; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }
.track-card:hover { transform: translateY(-5px); border-color: rgba(255, 255, 255, 0.5); box-shadow: 0 16px 36px rgba(255, 255, 255, 0.2); background: #161c30; }""",
""".track-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid #e4e4e7; border-radius: 18px; background: #ffffff; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }
.track-card:hover { transform: translateY(-5px); border-color: #000000; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); background: #fafafa; }"""
)

# 6. Site footer
css = css.replace(
""".site-footer { border-top: 1px solid var(--line); background: #0d0d0d; }""",
""".site-footer { border-top: 1px solid #e4e4e7; background: #fafafa; color: #18181b; }"""
)

# 7. Player icon and play button
css = css.replace(
""".player-icon:hover {
  color: #1c1917;
  background: #1c1c1c;
  transform: translateY(-1px);
}""",
""".player-icon:hover {
  color: #000000;
  background: #f4f4f5;
  transform: translateY(-1px);
}"""
)

css = css.replace(
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
}
.player-play:hover {
  transform: scale(1.06);
  box-shadow: 0 6px 20px rgba(255, 255, 255, 0.46), inset 0 1px 1px rgba(255, 255, 255, 0.45);
}
.player-play svg {
  width: 17px;
  height: 17px;
}""",
""".player-play {
  width: 40px;
  height: 40px;
  display: grid;
  place-items: center;
  margin-inline: 4px;
  border: 0;
  border-radius: 50%;
  color: #ffffff !important;
  background: #000000;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  transition: transform 0.18s ease, box-shadow 0.18s ease;
}
.player-play:hover {
  transform: scale(1.06);
  background: #27272a;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.35);
}
.player-play svg {
  width: 17px;
  height: 17px;
  color: #ffffff !important;
  fill: #ffffff !important;
}"""
)

# 8. Queue item
css = css.replace(
""".queue-item:hover, .queue-item--active {
  background: #1c1c1c;
}
.queue-item img {
  width: 42px;
  height: 42px;
  border-radius: 8px;
  object-fit: cover;
}
.queue-item > span {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 3px;
}
.queue-item b {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 11px;
  color: #1c1917;
}
.queue-item small {
  color: #786f65;
  font-size: 9px;
}""",
""".queue-item:hover {
  background: #f4f4f5;
}
.queue-item--active {
  background: #f4f4f5;
  border-left: 3px solid #000000;
}
.queue-item img {
  width: 42px;
  height: 42px;
  border-radius: 8px;
  object-fit: cover;
}
.queue-item > span {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 3px;
}
.queue-item b {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 11px;
  color: #000000;
  font-weight: 700;
}
.queue-item small {
  color: #71717a;
  font-size: 9px;
}"""
)

with open(r"frontend/src/styles.css", "w", encoding="utf-8") as f:
    f.write(css)

print("Updated styles.css successfully!")
