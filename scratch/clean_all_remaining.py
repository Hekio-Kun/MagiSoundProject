# Clean remaining collisions in styles.css, app-shell.css, and redesign.css

# 1. styles.css
with open(r"frontend/src/styles.css", "r", encoding="utf-8") as f:
    css_s = f.read()

# Replace all lingering #131828 in styles.css
css_s = css_s.replace("background: #131828;", "background: #f4f4f5;")
css_s = css_s.replace("background: #181818;", "background: #ffffff;")
css_s = css_s.replace("rgba(19, 24, 40, 0.88)", "rgba(255, 255, 255, 0.95)")
css_s = css_s.replace("color: #94a3b8;", "color: #52525b;")
css_s = css_s.replace("color: #f8fafc;", "color: #18181b;")

css_s = css_s.replace(
    ".player-play:hover {\n  transform: scale(1.06);\n  background: #27272a;\n  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.35);\n}",
    ".player-play:hover {\n  transform: scale(1.06);\n  background: #27272a;\n  color: #ffffff !important;\n  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.35);\n}"
)

css_s = css_s.replace(
    "background: linear-gradient(135deg, #ffffff 0%, #0d0d0d 100%);",
    "background: linear-gradient(135deg, #ffffff 0%, #f4f4f5 100%); border: 1px solid #e4e4e7; color: #000000;"
)

with open(r"frontend/src/styles.css", "w", encoding="utf-8") as f:
    f.write(css_s)
print("Cleaned styles.css remaining!")

# 2. app-shell.css
with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    css_a = f.read()

css_a = css_a.replace(
""".queue-reorder-btn:hover:not(:disabled) {
  background: #262626;
  color: #1c1917;
}""",
""".queue-reorder-btn:hover:not(:disabled) {
  background: #f4f4f5;
  color: #000000;
}"""
)

css_a = css_a.replace("background: #1f1f1f;", "background: #f4f4f5; color: #000000;")
css_a = css_a.replace("background: #121212;", "background: #fafafa;")
css_a = css_a.replace(
    "linear-gradient(135deg, #1f1f1f 0%, #ffffff 58%, #121212 100%)",
    "linear-gradient(135deg, #f4f4f5 0%, #ffffff 58%, #fafafa 100%)"
)

with open(r"frontend/src/app-shell.css", "w", encoding="utf-8") as f:
    f.write(css_a)
print("Cleaned app-shell.css remaining!")

# 3. redesign.css
with open(r"frontend/src/redesign.css", "r", encoding="utf-8") as f:
    css_r = f.read()

css_r = css_r.replace(
""".sw-filter-scroll button { flex: 0 0 auto; min-height: 34px; padding: 0 14px; border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 10px; background: #1c1c1c; color: #94a3b8; font-size: 11px; font-weight: 600; transition: all .18s ease; }
.sw-filter-scroll button:hover { background: #242424; border-color: rgba(255, 255, 255, 0.35); color: #f8fafc; }""",
""".sw-filter-scroll button { flex: 0 0 auto; min-height: 34px; padding: 0 14px; border: 1px solid #e4e4e7; border-radius: 10px; background: #f4f4f5; color: #52525b; font-size: 11px; font-weight: 600; transition: all .18s ease; }
.sw-filter-scroll button:hover { background: #e4e4e7; border-color: #000000; color: #000000; }"""
)

css_r = css_r.replace(
""".sw-empty button { margin-top: 8px; padding: 9px 13px; border: 0; border-radius: 9px; background: #1f1f1f; color: var(--sw-primary-dark); font-weight: 700; }""",
""".sw-empty button { margin-top: 8px; padding: 9px 13px; border: 0; border-radius: 9px; background: #000000; color: #ffffff !important; font-weight: 700; }"""
)

css_r = css_r.replace(
"""background: linear-gradient(110deg, #1f1f1f, #121212);""",
"""background: linear-gradient(110deg, #f4f4f5, #e4e4e7);"""
)

css_r = css_r.replace(
""".demo-role-grid button.is-active { border-color: #000000; background: #1f1f1f; color: var(--sw-primary-dark); }""",
""".demo-role-grid button.is-active { border-color: #000000; background: #000000; color: #ffffff !important; }"""
)

css_r = css_r.replace(
""".topbar-icon-btn:hover, .topbar-icon-btn.is-active {
  border-color: var(--sw-primary);
  background: #1f1f1f;
  color: var(--sw-primary-dark);
}""",
""".topbar-icon-btn:hover, .topbar-icon-btn.is-active {
  border-color: #000000;
  background: #e4e4e7;
  color: #000000;
}"""
)

css_r = css_r.replace(
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

with open(r"frontend/src/redesign.css", "w", encoding="utf-8") as f:
    f.write(css_r)
print("Cleaned redesign.css remaining!")
