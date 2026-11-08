with open(r"frontend/src/dashboard.css", "r", encoding="utf-8") as f:
    css = f.read()

old_root = """:root {
  --ops-brand: #ffffff;
  --ops-brand-hover: #e5e5e5;
  --ops-brand-light: #e4e4e7;
  --ops-brand-border: #404040;
  --ops-bg: #ffffff;
  --ops-card-bg: #ffffff;
  --ops-border: #e4e4e7;
  --ops-border-subtle: #1c1c1c;
  --ops-text-main: #ffffff;
  --ops-text-secondary: #a3a3a3;
  --ops-text-muted: #737373;"""

new_root = """:root {
  --ops-brand: #000000;
  --ops-brand-hover: #27272a;
  --ops-brand-light: #f4f4f5;
  --ops-brand-border: #e4e4e7;
  --ops-bg: #ffffff;
  --ops-card-bg: #ffffff;
  --ops-border: #e4e4e7;
  --ops-border-subtle: #f4f4f5;
  --ops-text-main: #000000;
  --ops-text-secondary: #52525b;
  --ops-text-muted: #71717a;"""

css = css.replace(old_root, new_root)

css = css.replace(
"""  --ops-violet: #ffffff;
  --ops-violet-light: #e4e4e7;""",
"""  --ops-violet: #000000;
  --ops-violet-light: #f4f4f5;"""
)

css = css.replace(
""".staff-metric-card.is-amber.is-selected-filter {
  border-color: var(--ops-amber);
  background: linear-gradient(180deg, #141414 0%, #ffffff 100%);
}""",
""".staff-metric-card.is-amber.is-selected-filter {
  border-color: var(--ops-amber);
  background: linear-gradient(180deg, #fffdfa 0%, #ffffff 100%);
}"""
)

with open(r"frontend/src/dashboard.css", "w", encoding="utf-8") as f:
    f.write(css)

print("Updated dashboard.css successfully!")
