with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    css = f.read()

# 1. explore-sort-selector select
css = css.replace(
"""public_placeholder_replaced_if_any""", """"""
)
css = css.replace(
""".explore-sort-selector select {
  padding: 6px 12px;
  border: 1px solid #d0d5dd;
  border-radius: 8px;
  background: #ffffff;
  font-size: 13px;
  color: #ffffff;
  outline: none;
}""",
""".explore-sort-selector select {
  padding: 6px 12px;
  border: 1px solid #e4e4e7;
  border-radius: 8px;
  background: #ffffff;
  font-size: 13px;
  color: #000000;
  outline: none;
}"""
)

# 2. status-pill--pending
css = css.replace(
""".status-pill--pending,
.status-badge--pending {
  background: #fef3c7;
  color: #ffffff;
  border: 1px solid #ffffff;
}""",
""".status-pill--pending,
.status-badge--pending {
  background: #fef3c7;
  color: #92400e;
  border: 1px solid #fde68a;
  font-weight: 700;
}"""
)

# 3. auth-title
css = css.replace(
""".auth-title {
  margin: 0 0 8px;
  font-size: 24px;
  font-weight: 800;
  color: #ffffff;
}""",
""".auth-title {
  margin: 0 0 8px;
  font-size: 24px;
  font-weight: 800;
  color: #000000;
}"""
)

# 4. studio-modal-heading .eyebrow
css = css.replace(
""".studio-modal-heading .eyebrow {
  color: #ffffff;
  font-size: 10px;
}""",
""".studio-modal-heading .eyebrow {
  color: #71717a;
  font-size: 10px;
}"""
)

# 5. profile-avatar-editor small
css = css.replace(
""".profile-avatar-editor small {
  display: block;
  overflow: hidden;
  margin-top: 5px;
  color: #ffffff;
  font-size: 9px;
  font-weight: 650;
  text-overflow: ellipsis;
  white-space: nowrap;
}""",
""".profile-avatar-editor small {
  display: block;
  overflow: hidden;
  margin-top: 5px;
  color: #71717a;
  font-size: 9px;
  font-weight: 650;
  text-overflow: ellipsis;
  white-space: nowrap;
}"""
)

# 6. album-card-title
css = css.replace(
""".album-card-title {
  font-size: 13.5px;
  font-weight: 700;
  color: #ffffff;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}""",
""".album-card-title {
  font-size: 13.5px;
  font-weight: 700;
  color: #000000;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}"""
)

# 7. track-creator-name:hover
css = css.replace(
""".track-creator-name:hover {
  color: #ffffff;
}""",
""".track-creator-name:hover {
  color: #000000;
  text-decoration: underline;
}"""
)

# 8. profile-about-card > button, .profile-card-heading > button
css = css.replace(
""".profile-about-card > button,
.profile-card-heading > button {
  border: 0;
  background: transparent;
  color: #ffffff;
  font-size: 10px;
  font-weight: 700;
  cursor: pointer;
  padding: 0;
}""",
""".profile-about-card > button,
.profile-card-heading > button {
  border: 0;
  background: transparent;
  color: #000000;
  font-size: 10px;
  font-weight: 700;
  cursor: pointer;
  padding: 0;
}"""
)

with open(r"frontend/src/app-shell.css", "w", encoding="utf-8") as f:
    f.write(css)

print("Misc app-shell fixes applied!")
