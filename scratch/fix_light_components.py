with open("frontend/src/redesign.css", "r", encoding="utf-8") as f:
    text = f.read()

# Refine .sw-track-card
text = text.replace(
    ".sw-track-card:hover, .sw-album-card:hover { transform: translateY(-4px); border-color: #555555; background: #161616; }",
    ".sw-track-card:hover, .sw-album-card:hover { transform: translateY(-4px); border-color: #d4d4d8; background: #fafafa; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); }"
)

# Refine .sw-track-play
text = text.replace(
    ".sw-track-play { position: absolute; right: 10px; bottom: 10px; z-index: 2; width: 42px; height: 42px; display: grid; place-items: center; border-radius: 50%; background: #ffffff; color: #000000; box-shadow: 0 4px 18px rgba(0, 0, 0, 0.7); opacity: 0; transform: translateY(6px); transition: opacity .2s, transform .2s, background .15s; }",
    ".sw-track-play { position: absolute; right: 10px; bottom: 10px; z-index: 2; width: 42px; height: 42px; display: grid; place-items: center; border-radius: 50%; background: #000000; color: #ffffff; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25); opacity: 0; transform: translateY(6px); transition: opacity .2s, transform .2s, background .15s; }"
)

text = text.replace(
    ".sw-track-card:hover .sw-track-play, .sw-album-card:hover .sw-track-play, .sw-track-card--active .sw-track-play, .sw-track-cover:focus-visible .sw-track-play, .sw-album-art:focus-visible .sw-track-play { position: absolute; right: 10px; bottom: 10px; z-index: 2; width: 42px; height: 42px; display: grid; place-items: center; border-radius: 50%; background: #ffffff; color: #000000; box-shadow: 0 4px 18px rgba(0, 0, 0, 0.7); opacity: 0; transform: translateY(6px); transition: opacity .2s, transform .2s, background .15s; }",
    ".sw-track-card:hover .sw-track-play, .sw-album-card:hover .sw-track-play, .sw-track-card--active .sw-track-play, .sw-track-cover:focus-visible .sw-track-play, .sw-album-art:focus-visible .sw-track-play { position: absolute; right: 10px; bottom: 10px; z-index: 2; width: 42px; height: 42px; display: grid; place-items: center; border-radius: 50%; background: #000000; color: #ffffff; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25); opacity: 0; transform: translateY(6px); transition: opacity .2s, transform .2s, background .15s; }"
)

# Refine .sw-creator-card
text = text.replace(
    ".sw-creator-card { display: grid; grid-template-columns: 72px minmax(0, 1fr) auto; align-items: center; gap: 16px; padding: 17px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #ffffff; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }",
    ".sw-creator-card { display: grid; grid-template-columns: 72px minmax(0, 1fr) auto; align-items: center; gap: 16px; padding: 17px; border: 1px solid #e4e4e7; border-radius: 18px; background: #ffffff; box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }"
)

text = text.replace(
    ".sw-creator-card:hover { transform: translateY(-4px); border-color: rgba(255, 255, 255, 0.45); box-shadow: 0 14px 32px rgba(255, 255, 255, 0.2); background: #161616; }",
    ".sw-creator-card:hover { transform: translateY(-4px); border-color: #d4d4d8; box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); background: #fafafa; }"
)

text = text.replace(
    ".sw-creator-avatar { width: 72px; height: 72px; aspect-ratio: 1 / 1; overflow: hidden; padding: 0; border: 0; border-radius: 50%; background: #1f1f1f; flex-shrink: 0; }",
    ".sw-creator-avatar { width: 72px; height: 72px; aspect-ratio: 1 / 1; overflow: hidden; padding: 0; border: 0; border-radius: 50%; background: #f4f4f5; flex-shrink: 0; }"
)

text = text.replace(
    ".sw-follow-button { padding: 8px 12px; border: 1px solid var(--sw-sand-border); border-radius: 9px; background: #f4f4f5; color: #e5e5e5; font-size: 10px; font-weight: 700; transition: all .16s ease; }",
    ".sw-follow-button { padding: 8px 12px; border: 1px solid #e4e4e7; border-radius: 9px; background: #f4f4f5; color: #000000; font-size: 10px; font-weight: 700; transition: all .16s ease; }"
)

text = text.replace(
    ".sw-follow-button:hover { background: var(--sw-primary); border-color: var(--sw-primary); color: #fff; }",
    ".sw-follow-button:hover { background: #000000; border-color: #000000; color: #ffffff; }"
)

text = text.replace(
    ".sw-release-row:hover, .sw-release-row.is-active { background: rgba(255, 255, 255, 0.12); }",
    ".sw-release-row:hover, .sw-release-row.is-active { background: #f4f4f5; }"
)

with open("frontend/src/redesign.css", "w", encoding="utf-8") as f:
    f.write(text)

print("Updated light component styles in redesign.css.")
