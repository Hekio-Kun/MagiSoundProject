with open('frontend/src/redesign.css', 'r', encoding='utf-8') as f:
    text = f.read()

# Replace track card styles
old_card = '''.sw-track-card, .sw-album-card { min-width: 0; padding: 10px 10px 14px; border: 1px solid var(--sw-border); border-radius: 17px; background: #fff; box-shadow: 0 2px 10px rgba(180, 140, 90, 0.05); transition: transform .2s, box-shadow .2s, border-color .2s; }
.sw-track-card:hover, .sw-album-card:hover { transform: translateY(-4px); border-color: var(--sw-sand); box-shadow: 0 12px 28px rgba(180, 140, 90, 0.15); }
.sw-track-card--active { border-color: var(--sw-primary); background: #f0f9ff; }'''

new_card = '''.sw-track-card, .sw-album-card { min-width: 0; padding: 12px 12px 16px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #121626; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease, background .25s ease; }
.sw-track-card:hover, .sw-album-card:hover { transform: translateY(-5px); border-color: rgba(139, 92, 246, 0.45); box-shadow: 0 16px 36px rgba(139, 92, 246, 0.22); background: #161c32; }
.sw-track-card--active { border-color: var(--sw-primary); background: rgba(139, 92, 246, 0.14); box-shadow: 0 0 25px rgba(139, 92, 246, 0.25); }'''

text = text.replace(old_card, new_card)

# Replace creator card styles
old_creator = '''.sw-creator-card { display: grid; grid-template-columns: 72px minmax(0, 1fr) auto; align-items: center; gap: 16px; padding: 17px; border: 1px solid var(--sw-border); border-radius: 17px; background: #fff; box-shadow: 0 2px 10px rgba(180, 140, 90, 0.05); transition: transform .2s, box-shadow .2s, border-color .2s; }
.sw-creator-card:hover { transform: translateY(-2px); border-color: var(--sw-sand); box-shadow: 0 12px 28px rgba(180, 140, 90, 0.12); }'''

new_creator = '''.sw-creator-card { display: grid; grid-template-columns: 72px minmax(0, 1fr) auto; align-items: center; gap: 16px; padding: 17px; border: 1px solid rgba(255, 255, 255, 0.07); border-radius: 18px; background: #121626; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35); transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease; }
.sw-creator-card:hover { transform: translateY(-4px); border-color: rgba(139, 92, 246, 0.45); box-shadow: 0 14px 32px rgba(139, 92, 246, 0.2); background: #161c32; }'''

text = text.replace(old_creator, new_creator)

# Replace release row hover
text = text.replace('.sw-release-row:hover, .sw-release-row.is-active { background: #f0fdff; }', '.sw-release-row:hover, .sw-release-row.is-active { background: rgba(139, 92, 246, 0.12); }')
text = text.replace('border-top: 1px solid #f0f2f5;', 'border-top: 1px solid rgba(255, 255, 255, 0.05);')

# Replace catalog toolbar & filters
old_toolbar = '''.sw-catalog-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 16px; margin-bottom: 20px; padding: 9px; border: 1px solid var(--sw-border); border-radius: 14px; background: #fff; }
.sw-filter-scroll { min-width: 0; display: flex; gap: 6px; overflow-x: auto; scrollbar-width: none; }
.sw-filter-scroll::-webkit-scrollbar { display: none; }
.sw-filter-scroll button { flex: 0 0 auto; min-height: 34px; padding: 0 13px; border: 1px solid var(--sw-sand-border); border-radius: 9px; background: #fbf4ea; color: #785028; font-size: 10.5px; font-weight: 600; transition: all .15s ease; }
.sw-filter-scroll button:hover { background: #f5ead8; border-color: var(--sw-sand); color: #5c3a15; }
.sw-filter-scroll button.is-active { background: var(--sw-primary); border-color: var(--sw-primary); color: #fff; box-shadow: 0 5px 14px rgba(2, 132, 199, .2); }
.sw-sort { flex: 0 0 auto; display: flex; align-items: center; gap: 6px; padding-inline: 10px; border-left: 1px solid var(--sw-border); color: var(--sw-muted); }
.sw-sort select { height: 34px; border: 0; outline: 0; background: #fff; color: var(--sw-text); font-size: 10.5px; font-weight: 600; }'''

new_toolbar = '''.sw-catalog-toolbar { display: flex; align-items: center; justify-content: space-between; gap: 16px; margin-bottom: 20px; padding: 10px 14px; border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 16px; background: #121626; }
.sw-filter-scroll { min-width: 0; display: flex; gap: 8px; overflow-x: auto; scrollbar-width: none; }
.sw-filter-scroll::-webkit-scrollbar { display: none; }
.sw-filter-scroll button { flex: 0 0 auto; min-height: 34px; padding: 0 14px; border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 10px; background: #1a2035; color: #94a3b8; font-size: 11px; font-weight: 600; transition: all .18s ease; }
.sw-filter-scroll button:hover { background: #222a44; border-color: rgba(139, 92, 246, 0.35); color: #f8fafc; }
.sw-filter-scroll button.is-active { background: linear-gradient(135deg, #8b5cf6, #6366f1); border-color: rgba(139, 92, 246, 0.5); color: #fff; box-shadow: 0 4px 16px rgba(139, 92, 246, 0.4); }
.sw-sort { flex: 0 0 auto; display: flex; align-items: center; gap: 6px; padding-inline: 10px; border-left: 1px solid rgba(255, 255, 255, 0.08); color: #94a3b8; }
.sw-sort select { height: 34px; border: 1px solid rgba(255, 255, 255, 0.08); border-radius: 8px; outline: 0; background: #181f34; color: #f8fafc; font-size: 11px; font-weight: 600; padding: 0 8px; }'''

text = text.replace(old_toolbar, new_toolbar)

with open('frontend/src/redesign.css', 'w', encoding='utf-8') as f:
    f.write(text)
print('Updated cards and catalog in redesign.css')
