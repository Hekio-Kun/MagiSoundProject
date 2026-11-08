with open(r"frontend/src/auth-redesign.css", "r", encoding="utf-8") as f:
    css = f.read()

# 1. Replace all .auth-v2-workspace backgrounds
import re
css = re.sub(
    r'background:\s*radial-gradient\([^;]*?\),\s*#000000;',
    'background: #ffffff; color: #000000;',
    css
)

# 2. Heading
css = css.replace(
""".auth-v2-heading h1 { margin: 0; color: #f8fafc; font-size: clamp(28px, 3vw, 38px); line-height: 1.15; letter-spacing: -.045em; }""",
""".auth-v2-heading h1 { margin: 0; color: #000000; font-size: clamp(28px, 3vw, 38px); line-height: 1.15; letter-spacing: -.045em; }"""
)
css = css.replace(
""".auth-v2-heading p { max-width: 520px; margin: 10px 0 0; color: #667085; font-size: 11.5px; line-height: 1.65; }""",
""".auth-v2-heading p { max-width: 520px; margin: 10px 0 0; color: #52525b; font-size: 11.5px; line-height: 1.65; }"""
)

# 3. Field label
css = css.replace(
""".auth-v2-field > label, .auth-v2-label-row label { color: #cbd5e1; font-size: 10px; font-weight: 700; }""",
""".auth-v2-field > label, .auth-v2-label-row label { color: #18181b; font-size: 10px; font-weight: 700; }"""
)

# 4. Tabs
old_tabs = """.auth-v2-tabs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 5px;
  margin-bottom: 27px;
  padding: 5px;
  border: 1px solid rgba(255, 255, 255, 0.08);
  border-radius: 13px;
  background: #ffffff;
}

.auth-v2-tabs button {
  min-height: 40px;
  border: 0;
  border-radius: 9px;
  background: transparent;
  color: #667085;
  font-size: 10.5px;
  font-weight: 700;
  cursor: pointer;
}

.auth-v2-tabs button:hover { color: #101828; }
.auth-v2-tabs button.is-active {
  background: #ffffff; color: #000000;
  color: #fff;
  box-shadow: 0 4px 16px rgba(255, 255, 255, 0.4);
}"""

new_tabs = """.auth-v2-tabs {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 5px;
  margin-bottom: 27px;
  padding: 5px;
  border: 1px solid #e4e4e7;
  border-radius: 13px;
  background: #f4f4f5;
}

.auth-v2-tabs button {
  min-height: 40px;
  border: 0;
  border-radius: 9px;
  background: transparent;
  color: #52525b;
  font-size: 10.5px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.15s ease;
}

.auth-v2-tabs button:hover { color: #000000; }
.auth-v2-tabs button.is-active {
  background: #000000;
  color: #ffffff !important;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}"""
css = css.replace(old_tabs, new_tabs)

# 5. Inputs
old_input = """.auth-v2-input {
  height: 48px;
  display: grid;
  grid-template-columns: 36px minmax(0, 1fr);
  align-items: center;
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  background: #ffffff;
  color: #f8fafc;
  transition: border-color .15s, box-shadow .15s;
}
.auth-v2-input:focus-within {
  border-color: #000000;
  box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.25);
  background: #181d32;
}
.auth-v2-input input {
  color: #f8fafc;
}

.auth-v2-input:focus-within { border-color: #000000; box-shadow: 0 0 0 3px rgba(255, 255, 255, .11); }"""

new_input = """.auth-v2-input {
  height: 48px;
  display: grid;
  grid-template-columns: 36px minmax(0, 1fr);
  align-items: center;
  border: 1px solid #e4e4e7;
  border-radius: 12px;
  background: #f4f4f5;
  color: #000000;
  transition: border-color .15s, box-shadow .15s, background .15s;
}
.auth-v2-input:focus-within {
  border-color: #000000;
  box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.08);
  background: #ffffff;
}
.auth-v2-input input {
  color: #000000 !important;
}"""
css = css.replace(old_input, new_input)

css = css.replace(
""".auth-v2-input input { width: 100%; height: 100%; min-width: 0; padding: 0 12px 0 0; border: 0; outline: 0; background: transparent; color: #101828; font-size: 11px; }""",
""".auth-v2-input input { width: 100%; height: 100%; min-width: 0; padding: 0 12px 0 0; border: 0; outline: 0; background: transparent; color: #000000 !important; font-size: 11px; }"""
)

# 6. Submit button
old_submit = """.auth-v2-submit {
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
}
.auth-v2-submit:hover {
  background: linear-gradient(135deg, #e5e5e5, #4f46e5);
  box-shadow: 0 12px 30px rgba(255, 255, 255, 0.55);
}"""

new_submit = """.auth-v2-submit {
  width: 100%;
  min-height: 49px;
  margin-top: 1px;
  background: #000000 !important;
  color: #ffffff !important;
  font-weight: 800;
  border: 1px solid #000000 !important;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
  cursor: pointer;
  transition: all 0.18s ease;
}
.auth-v2-submit:hover {
  background: #27272a !important;
  color: #ffffff !important;
  border-color: #27272a !important;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
  transform: translateY(-1px);
}"""
css = css.replace(old_submit, new_submit)

# 7. Back home
css = css.replace(
""".auth-v2-back-home {
  position: absolute;
  top: 26px;
  left: clamp(34px, 4vw, 62px);
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 8px 10px;
  border: 0;
  border-radius: 9px;
  background: transparent;
  color: #667085;
  font-size: 9.5px;
  font-weight: 700;
  cursor: pointer;
}

.auth-v2-back-home:hover { background: #f2f4f7; color: #000000; }""",
""".auth-v2-back-home {
  position: absolute;
  top: 26px;
  left: clamp(34px, 4vw, 62px);
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 8px 12px;
  border: 1px solid #e4e4e7;
  border-radius: 9px;
  background: #f4f4f5;
  color: #18181b;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.15s ease;
}

.auth-v2-back-home:hover { background: #e4e4e7; color: #000000; border-color: #000000; }"""
)

with open(r"frontend/src/auth-redesign.css", "w", encoding="utf-8") as f:
    f.write(css)

print("Updated auth-redesign.css successfully!")
