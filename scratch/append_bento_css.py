with open("frontend/src/redesign.css", "a", encoding="utf-8") as f:
    f.write('''

/* ==========================================================================
   MagiSound Monochrome Noir - Bento Stage and Dual-Feed Layout
   ========================================================================== */

/* 1. Bento Spotlight Stage (Top of Explore) */
.ms-bento-stage {
  display: grid;
  grid-template-columns: minmax(0, 1.62fr) minmax(300px, 0.98fr);
  gap: 20px;
  margin-bottom: 24px;
}

@media (max-width: 992px) {
  .ms-bento-stage {
    grid-template-columns: 1fr;
  }
}

.ms-bento-card {
  position: relative;
  overflow: hidden;
  border-radius: 24px;
  border: 1px solid #222222;
  background: #0d0d0d;
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.6);
  transition: border-color 0.25s ease;
}

.ms-bento-card:hover {
  border-color: #383838;
}

/* Spotlight Card (Large Bento) */
.ms-bento-spotlight {
  padding: 34px 36px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 380px;
  background: radial-gradient(circle at 90% 15%, rgba(255, 255, 255, 0.08) 0%, transparent 60%),
              linear-gradient(135deg, #141414 0%, #0a0a0a 100%);
}

.ms-bento-spotlight-top {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 24px;
}

.ms-bento-spotlight-info {
  flex: 1;
  min-width: 0;
}

.ms-bento-kicker {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 11px;
  font-weight: 800;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: #a3a3a3;
  margin-bottom: 12px;
}

.ms-bento-kicker svg {
  color: #ffffff;
}

.ms-bento-title {
  margin: 0 0 10px;
  font-size: clamp(26px, 3.2vw, 42px);
  font-weight: 800;
  line-height: 1.15;
  letter-spacing: -0.04em;
  color: #ffffff;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.ms-bento-artist {
  margin: 0 0 20px;
  font-size: 14px;
  color: #a3a3a3;
}

.ms-bento-artist strong {
  color: #ffffff;
  font-weight: 600;
}

.ms-bento-cover {
  width: 140px;
  height: 140px;
  border-radius: 18px;
  overflow: hidden;
  border: 1px solid #282828;
  flex-shrink: 0;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7);
}

.ms-bento-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.ms-bento-actions {
  display: flex;
  align-items: center;
  gap: 14px;
  flex-wrap: wrap;
  margin-top: 24px;
}

.ms-btn-listen {
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
}

.ms-btn-listen:active {
  transform: translateY(0);
}

.ms-btn-details {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 12px 20px;
  border-radius: 9999px;
  background: #181818;
  color: #ffffff;
  font-size: 13px;
  font-weight: 600;
  border: 1px solid #333333;
  cursor: pointer;
  transition: background 0.18s ease, border-color 0.18s ease;
}

.ms-btn-details:hover {
  background: #222222;
  border-color: #555555;
}

.ms-bento-wave-badge {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  border-radius: 9999px;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.15);
  margin-left: auto;
}

.ms-bento-wave-badge span {
  font-size: 11px;
  font-weight: 700;
  color: #ffffff;
}

.ms-bento-proof-strip {
  display: flex;
  align-items: center;
  gap: 24px;
  padding-top: 24px;
  border-top: 1px solid #1f1f1f;
  margin-top: 28px;
  flex-wrap: wrap;
}

.ms-bento-proof-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.ms-bento-proof-item b {
  font-size: 15px;
  font-weight: 800;
  color: #ffffff;
}

.ms-bento-proof-item small {
  font-size: 10px;
  color: #737373;
  text-transform: uppercase;
  letter-spacing: 0.06em;
}

/* Pulse Card (Side Bento) */
.ms-bento-pulse {
  padding: 30px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  background: linear-gradient(150deg, #121212 0%, #0a0a0a 100%);
}

.ms-bento-pulse-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.ms-bento-pulse-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 800;
  color: #ffffff;
  letter-spacing: -0.02em;
}

.ms-bento-pulse-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 3px 9px;
  border-radius: 9999px;
  background: #1f1f1f;
  border: 1px solid #333333;
  font-size: 10px;
  font-weight: 700;
  color: #ffffff;
}

.ms-bento-pulse-tag i {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: #ffffff;
  animation: msPulse 1.8s infinite;
}

@keyframes msPulse {
  0% { transform: scale(0.9); opacity: 0.5; }
  50% { transform: scale(1.3); opacity: 1; }
  100% { transform: scale(0.9); opacity: 0.5; }
}

.ms-bento-metrics-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
  margin-bottom: 24px;
}

.ms-bento-metric-cell {
  padding: 16px;
  border-radius: 16px;
  background: #161616;
  border: 1px solid #222222;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.ms-bento-metric-cell strong {
  font-size: 20px;
  font-weight: 800;
  color: #ffffff;
}

.ms-bento-metric-cell span {
  font-size: 10.5px;
  color: #a3a3a3;
  line-height: 1.35;
}

.ms-bento-pulse-cta {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 13px 18px;
  border-radius: 14px;
  background: #181818;
  border: 1px solid #2a2a2a;
  color: #ffffff;
  font-size: 12px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}

.ms-bento-pulse-cta:hover {
  background: #222222;
  border-color: #ffffff;
}

/* 2. Interactive Genre Filter Bar */
.ms-genre-pill-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  overflow-x: auto;
  scrollbar-width: none;
  padding: 6px 0 20px;
  margin-bottom: 4px;
}

.ms-genre-pill-bar::-webkit-scrollbar {
  display: none;
}

.ms-genre-pill {
  flex: 0 0 auto;
  padding: 8px 18px;
  border-radius: 9999px;
  font-size: 12px;
  font-weight: 700;
  border: 1px solid #282828;
  background: #121212;
  color: #a3a3a3;
  cursor: pointer;
  transition: all 0.18s ease;
}

.ms-genre-pill:hover {
  color: #ffffff;
  border-color: #484848;
  background: #181818;
}

.ms-genre-pill--active {
  background: #ffffff !important;
  color: #000000 !important;
  border-color: #ffffff !important;
  box-shadow: 0 2px 14px rgba(255, 255, 255, 0.2);
}

/* 3. Asymmetric Dual-Feed Container */
.ms-dual-feed {
  display: grid;
  grid-template-columns: minmax(0, 1.62fr) minmax(320px, 0.98fr);
  gap: 28px;
  align-items: start;
}

@media (max-width: 1040px) {
  .ms-dual-feed {
    grid-template-columns: 1fr;
  }
}

.ms-feed-main {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.ms-feed-sidebar {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* Section Header in Monochrome */
.ms-feed-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 16px;
  margin-bottom: 18px;
}

.ms-feed-header h2 {
  margin: 0;
  font-size: 20px;
  font-weight: 800;
  color: #ffffff;
  letter-spacing: -0.03em;
}

.ms-feed-header p {
  margin: 4px 0 0;
  font-size: 12px;
  color: #737373;
}

.ms-feed-header-action {
  font-size: 11px;
  font-weight: 700;
  color: #a3a3a3;
  background: none;
  border: 0;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.ms-feed-header-action:hover {
  color: #ffffff;
}

/* Main Feed Track Grid (3 columns) */
.ms-tracks-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}

@media (max-width: 768px) {
  .ms-tracks-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 480px) {
  .ms-tracks-grid {
    grid-template-columns: 1fr;
  }
}

/* High-Contrast Monochrome Track Card */
.ms-track-card {
  border-radius: 18px;
  border: 1px solid #1f1f1f;
  background: #0f0f0f;
  padding: 12px;
  transition: all 0.22s ease;
  position: relative;
  display: flex;
  flex-direction: column;
}

.ms-track-card:hover {
  border-color: #383838;
  background: #141414;
  transform: translateY(-3px);
}

.ms-track-card--active {
  border-color: #ffffff;
  background: #181818;
}

.ms-track-card-cover {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 12px;
  overflow: hidden;
  margin-bottom: 12px;
  background: #1c1c1c;
}

.ms-track-card-cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.35s ease;
}

.ms-track-card:hover .ms-track-card-cover img {
  transform: scale(1.05);
}

.ms-track-card-overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.ms-track-card:hover .ms-track-card-overlay,
.ms-track-card--active .ms-track-card-overlay {
  opacity: 1;
}

.ms-track-card-play-btn {
  width: 46px;
  height: 46px;
  border-radius: 50%;
  background: #ffffff;
  color: #000000;
  display: grid;
  place-items: center;
  border: 0;
  cursor: pointer;
  box-shadow: 0 4px 18px rgba(0, 0, 0, 0.8);
  transform: scale(0.9);
  transition: transform 0.18s ease;
}

.ms-track-card:hover .ms-track-card-play-btn {
  transform: scale(1);
}

.ms-track-card-info {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.ms-track-card-title {
  font-size: 13.5px;
  font-weight: 700;
  color: #ffffff;
  text-decoration: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ms-track-card-title:hover {
  text-decoration: underline;
}

.ms-track-card-artist {
  font-size: 11.5px;
  color: #8c8c8c;
  text-decoration: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ms-track-card-artist:hover {
  color: #ffffff;
}

.ms-track-card-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 6px;
  padding-top: 6px;
  border-top: 1px solid #1a1a1a;
  font-size: 10px;
  color: #737373;
}

/* 4. Top 5 Ranked Leaderboard */
.ms-leaderboard-box {
  border-radius: 20px;
  border: 1px solid #202020;
  background: #0d0d0d;
  padding: 22px 20px;
}

.ms-leaderboard-list {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.ms-leaderboard-row {
  display: grid;
  grid-template-columns: 28px 44px minmax(0, 1fr) 34px;
  align-items: center;
  gap: 12px;
  padding: 8px 10px;
  border-radius: 12px;
  border: 1px solid transparent;
  background: transparent;
  transition: background 0.18s ease, border-color 0.18s ease;
  cursor: pointer;
  text-align: left;
  width: 100%;
}

.ms-leaderboard-row:hover {
  background: #161616;
  border-color: #282828;
}

.ms-leaderboard-row.is-active {
  background: #1c1c1c;
  border-color: #383838;
}

.ms-leaderboard-rank {
  font-size: 13px;
  font-weight: 800;
  color: #737373;
  text-align: center;
}

.ms-leaderboard-row:nth-child(1) .ms-leaderboard-rank {
  color: #ffffff;
}

.ms-leaderboard-row:nth-child(2) .ms-leaderboard-rank {
  color: #e5e5e5;
}

.ms-leaderboard-row:nth-child(3) .ms-leaderboard-rank {
  color: #cccccc;
}

.ms-leaderboard-thumb {
  width: 44px;
  height: 44px;
  border-radius: 8px;
  overflow: hidden;
  background: #1e1e1e;
  flex-shrink: 0;
}

.ms-leaderboard-thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.ms-leaderboard-details {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.ms-leaderboard-title {
  font-size: 12.5px;
  font-weight: 700;
  color: #ffffff;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ms-leaderboard-artist {
  font-size: 10.5px;
  color: #8c8c8c;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ms-leaderboard-play-btn {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: #1c1c1c;
  color: #ffffff;
  display: grid;
  place-items: center;
  border: 1px solid #333333;
  transition: all 0.18s ease;
}

.ms-leaderboard-row:hover .ms-leaderboard-play-btn {
  background: #ffffff;
  color: #000000;
  border-color: #ffffff;
}

.ms-leaderboard-row.is-active .ms-leaderboard-play-btn {
  background: #ffffff;
  color: #000000;
  border-color: #ffffff;
}

/* 5. Creator Spotlight in Sidebar */
.ms-creator-box {
  border-radius: 20px;
  border: 1px solid #202020;
  background: #0d0d0d;
  padding: 22px 20px;
}

.ms-creator-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.ms-creator-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px;
  border-radius: 12px;
  transition: background 0.18s ease;
}

.ms-creator-item:hover {
  background: #141414;
}

.ms-creator-avatar-wrap {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  overflow: hidden;
  background: #1c1c1c;
  flex-shrink: 0;
  border: 1px solid #333333;
}

.ms-creator-avatar-wrap img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.ms-creator-info {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.ms-creator-name {
  font-size: 12.5px;
  font-weight: 700;
  color: #ffffff;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ms-creator-meta {
  font-size: 10px;
  color: #737373;
}

.ms-creator-btn {
  padding: 6px 14px;
  border-radius: 9999px;
  background: #181818;
  border: 1px solid #333333;
  color: #ffffff;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.18s ease;
}

.ms-creator-btn:hover {
  background: #ffffff;
  color: #000000;
  border-color: #ffffff;
}
''')
print("Appended Bento Stage & Dual-Feed styles to redesign.css successfully.")
