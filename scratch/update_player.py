import re

def update_player_dock():
    path = "frontend/src/styles.css"
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()

    new_player_block = '''/* Player - Floating Obsidian Glass Dock (MagiSound Mystic Aurora) */
.music-player {
  position: fixed;
  left: 20px;
  right: 20px;
  bottom: 16px;
  width: calc(100% - 40px);
  max-width: 1400px;
  margin: 0 auto;
  z-index: 60;
  height: 84px;
  display: grid;
  grid-template-columns: minmax(240px, 1fr) minmax(400px, 2fr) minmax(220px, 1fr);
  align-items: center;
  gap: 24px;
  padding: 10px clamp(20px, 3.5vw, 36px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.1);
  background: rgba(15, 19, 34, 0.88);
  box-shadow:
    0 20px 50px rgba(0, 0, 0, 0.65),
    0 0 30px rgba(139, 92, 246, 0.15),
    inset 0 1px 1px rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(28px);
  -webkit-backdrop-filter: blur(28px);
  transition: transform 0.24s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.24s ease;
}

.music-player::before {
  content: "";
  position: absolute;
  top: 0;
  left: 24px;
  right: 24px;
  height: 1px;
  background: linear-gradient(90deg, transparent 0%, rgba(139, 92, 246, 0.6) 30%, rgba(6, 182, 212, 0.6) 70%, transparent 100%);
  pointer-events: none;
}

.player-track {
  min-width: 0;
  display: flex;
  align-items: center;
  gap: 13px;
}
.player-track img {
  width: 52px;
  height: 52px;
  flex: 0 0 auto;
  border-radius: 12px;
  object-fit: cover;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.4);
  border: 1px solid rgba(255, 255, 255, 0.12);
}
.player-track > div {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 3px;
}
.player-track a:first-child {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-weight: 700;
  font-size: 13.5px;
  color: #f8fafc;
  letter-spacing: -0.01em;
}
.player-track a:first-child:hover {
  color: #c4b5fd;
}
.player-track a:last-child {
  color: #94a3b8;
  font-size: 11px;
  font-weight: 500;
}
.player-track a:last-child:hover {
  color: #f8fafc;
}

.player-center {
  min-width: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
}
.player-controls {
  display: flex;
  align-items: center;
  gap: 10px;
}
.player-icon {
  width: 32px;
  height: 32px;
  display: grid;
  place-items: center;
  border: 0;
  border-radius: 10px;
  color: #94a3b8;
  background: transparent;
  cursor: pointer;
  transition: all 0.18s ease;
}
.player-icon:hover {
  color: #f8fafc;
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-1px);
}
.player-icon svg {
  width: 16px;
  height: 16px;
}
.player-icon--active {
  color: #c4b5fd;
  background: rgba(139, 92, 246, 0.2);
}
.player-icon--active:hover {
  color: #fff;
  background: rgba(139, 92, 246, 0.3);
}

/* Play/Pause Button - Mystic Violet Jewel Style */
.player-play {
  width: 44px;
  height: 44px;
  display: grid;
  place-items: center;
  margin-inline: 4px;
  border: 0;
  border-radius: 50%;
  color: #fff;
  background: linear-gradient(135deg, #a855f7 0%, #8b5cf6 50%, #6366f1 100%);
  box-shadow: 0 4px 20px rgba(139, 92, 246, 0.5), inset 0 1px 1px rgba(255, 255, 255, 0.4);
  cursor: pointer;
  transition: transform 0.18s ease, box-shadow 0.18s ease;
}
.player-play:hover {
  transform: scale(1.08);
  box-shadow: 0 6px 26px rgba(139, 92, 246, 0.7), inset 0 1px 1px rgba(255, 255, 255, 0.5);
}
.player-play svg {
  width: 17px;
  height: 17px;
}

/* Timeline */
.timeline {
  width: min(100%, 540px);
  display: grid;
  grid-template-columns: 36px 1fr 36px;
  align-items: center;
  gap: 10px;
  color: #94a3b8;
  font-size: 10.5px;
  font-weight: 500;
  font-variant-numeric: tabular-nums;
}
.timeline span:last-child {
  text-align: right;
}

/* Range Sliders */
.music-player input[type="range"] {
  --range-progress: 0%;
  height: 5px;
  width: 100%;
  -webkit-appearance: none;
  appearance: none;
  border-radius: 999px;
  background: rgba(255, 255, 255, 0.12);
  outline: none;
  cursor: pointer;
  background-image: linear-gradient(90deg, #8b5cf6 0%, #06b6d4 100%);
  background-size: var(--range-progress) 100%;
  background-repeat: no-repeat;
  transition: height 0.14s ease, background 0.14s ease;
}

.music-player input[type="range"]:hover {
  height: 7px;
}

.music-player input[type="range"]::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 13px;
  height: 13px;
  border-radius: 50%;
  background: #ffffff;
  border: 2px solid #8b5cf6;
  box-shadow: 0 0 12px rgba(139, 92, 246, 0.8);
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.14s ease, transform 0.14s ease;
}

.music-player input[type="range"]:hover::-webkit-slider-thumb {
  opacity: 1;
  transform: scale(1.15);
}

.music-player input[type="range"]::-moz-range-thumb {
  width: 13px;
  height: 13px;
  border-radius: 50%;
  background: #ffffff;
  border: 2px solid #8b5cf6;
  box-shadow: 0 0 12px rgba(139, 92, 246, 0.8);
  cursor: pointer;
  opacity: 0;
  transition: opacity 0.14s ease, transform 0.14s ease;
}

.music-player input[type="range"]:hover::-moz-range-thumb {
  opacity: 1;
  transform: scale(1.15);
}'''

    # Replace from .music-player { down to the end of range input rules
    pattern = r'/\* Player - Full-Width Bottom Bar.*?(?=\.player-right)'
    content = re.sub(pattern, new_player_block + '\n\n', content, flags=re.DOTALL)

    with open(path, "w", encoding="utf-8") as f:
        f.write(content)
    print("Updated player dock in styles.css")

update_player_dock()
