with open("frontend/src/redesign.css", "a", encoding="utf-8") as f:
    f.write('''

/* ==========================================================================
   Spotify-Style Light Theme for MagiSound Explore Page
   ========================================================================== */

.sp-explore-page {
  padding-bottom: 50px;
  background: #ffffff;
  color: #000000;
  display: flex;
  flex-direction: column;
  gap: 36px;
}

/* Greeting Header */
.sp-greeting-header {
  margin-top: 4px;
  margin-bottom: 6px;
}

.sp-greeting-title {
  margin: 0;
  font-size: clamp(26px, 3.2vw, 34px);
  font-weight: 800;
  letter-spacing: -0.04em;
  color: #000000;
}

.sp-greeting-sub {
  margin: 4px 0 0;
  font-size: 13px;
  color: #71717a;
}

/* Quick Access 6-item Grid (2 rows x 3 columns) */
.sp-quick-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 12px;
}

@media (max-width: 900px) {
  .sp-quick-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 550px) {
  .sp-quick-grid {
    grid-template-columns: 1fr;
  }
}

.sp-quick-card {
  display: flex;
  align-items: center;
  background: #f4f4f5;
  border-radius: 6px;
  overflow: hidden;
  height: 64px;
  border: 1px solid #e4e4e7;
  cursor: pointer;
  transition: background 0.18s ease, transform 0.18s ease, box-shadow 0.18s ease;
  position: relative;
}

.sp-quick-card:hover {
  background: #e4e4e7;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.sp-quick-card--active {
  background: #e4e4e7;
  border-color: #000000;
}

.sp-quick-cover {
  width: 64px;
  height: 64px;
  object-fit: cover;
  flex-shrink: 0;
}

.sp-quick-info {
  flex: 1;
  min-width: 0;
  padding: 0 14px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.sp-quick-title {
  font-size: 13px;
  font-weight: 700;
  color: #000000;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.sp-quick-artist {
  font-size: 11px;
  color: #71717a;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.sp-quick-play {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff;
  display: grid;
  place-items: center;
  border: 0;
  cursor: pointer;
  margin-right: 12px;
  flex-shrink: 0;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
  opacity: 0;
  transform: translateY(4px);
  transition: opacity 0.2s ease, transform 0.2s ease, background 0.15s ease;
}

.sp-quick-card:hover .sp-quick-play,
.sp-quick-play.is-playing {
  opacity: 1;
  transform: translateY(0);
}

.sp-quick-play:hover {
  transform: scale(1.06);
  background: #27272a;
}

/* Sections and Headers */
.sp-section {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.sp-section-header {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  gap: 16px;
}

.sp-section-title {
  margin: 0;
  font-size: 20px;
  font-weight: 800;
  letter-spacing: -0.03em;
  color: #000000;
}

.sp-section-desc {
  margin: 3px 0 0;
  font-size: 12px;
  color: #71717a;
}

.sp-see-all {
  font-size: 12px;
  font-weight: 700;
  color: #71717a;
  background: none;
  border: 0;
  cursor: pointer;
  padding: 0;
  transition: color 0.18s ease;
}

.sp-see-all:hover {
  color: #000000;
  text-decoration: underline;
}

/* Shelf Grid (5 items standard) */
.sp-shelf-grid {
  display: grid;
  grid-template-columns: repeat(5, minmax(0, 1fr));
  gap: 18px;
}

@media (max-width: 1100px) {
  .sp-shelf-grid {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }
}

@media (max-width: 820px) {
  .sp-shelf-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

@media (max-width: 580px) {
  .sp-shelf-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

/* Spotify Track Card */
.sp-track-card {
  background: #ffffff;
  border: 1px solid #f0f0f2;
  border-radius: 8px;
  padding: 12px;
  cursor: pointer;
  transition: background 0.22s ease, box-shadow 0.22s ease, transform 0.22s ease;
  display: flex;
  flex-direction: column;
}

.sp-track-card:hover {
  background: #fafafa;
  border-color: #e4e4e7;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.07);
  transform: translateY(-3px);
}

.sp-track-card--active {
  background: #f4f4f5;
  border-color: #000000;
}

.sp-cover-wrap {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 6px;
  overflow: hidden;
  background: #f4f4f5;
  margin-bottom: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.sp-cover-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.sp-track-card:hover .sp-cover-img {
  transform: scale(1.03);
}

.sp-floating-play {
  position: absolute;
  right: 10px;
  bottom: 10px;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: #000000;
  color: #ffffff;
  display: grid;
  place-items: center;
  border: 0;
  cursor: pointer;
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.28);
  opacity: 0;
  transform: translateY(8px);
  transition: opacity 0.22s ease, transform 0.22s ease, background 0.15s ease;
}

.sp-track-card:hover .sp-floating-play,
.sp-floating-play.is-playing {
  opacity: 1;
  transform: translateY(0);
}

.sp-floating-play:hover {
  transform: scale(1.08);
  background: #27272a;
}

.sp-card-body {
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.sp-card-title {
  font-size: 13.5px;
  font-weight: 700;
  color: #000000;
  text-decoration: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.sp-card-title:hover {
  text-decoration: underline;
}

.sp-card-subtitle {
  font-size: 11.5px;
  color: #71717a;
  text-decoration: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.sp-card-subtitle:hover {
  color: #000000;
}

.sp-card-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 6px;
  padding-top: 6px;
  border-top: 1px solid #f4f4f5;
  font-size: 10.5px;
  color: #a1a1aa;
}

/* Spotify Artist Card */
.sp-artist-card {
  background: #ffffff;
  border: 1px solid #f0f0f2;
  border-radius: 8px;
  padding: 14px 12px;
  cursor: pointer;
  transition: background 0.22s ease, box-shadow 0.22s ease, transform 0.22s ease;
  display: flex;
  flex-direction: column;
}

.sp-artist-card:hover {
  background: #fafafa;
  border-color: #e4e4e7;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.07);
  transform: translateY(-3px);
}

.sp-artist-avatar-wrap {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  border-radius: 50%;
  overflow: hidden;
  background: #f4f4f5;
  margin-bottom: 14px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.sp-artist-avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.sp-artist-card:hover .sp-artist-avatar {
  transform: scale(1.04);
}

.sp-artist-card:hover .sp-floating-play {
  opacity: 1;
  transform: translateY(0);
}

/* Spotify Category Grid */
.sp-genre-grid {
  display: grid;
  grid-template-columns: repeat(6, minmax(0, 1fr));
  gap: 14px;
}

@media (max-width: 1100px) {
  .sp-genre-grid {
    grid-template-columns: repeat(4, minmax(0, 1fr));
  }
}

@media (max-width: 768px) {
  .sp-genre-grid {
    grid-template-columns: repeat(3, minmax(0, 1fr));
  }
}

@media (max-width: 500px) {
  .sp-genre-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

.sp-genre-card {
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
}
''')
print("Appended Spotify layout styles to redesign.css successfully.")
