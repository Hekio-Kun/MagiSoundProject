with open('frontend/src/pages/ExplorePage.tsx', 'r', encoding='utf-8') as f:
    text = f.read()

target1 = '''          <span className="discover-kicker"><i /> DISCOVER SOMETHING NEW EVERY DAY</span>
          <h1 id="discover-title">Music for<br /><span>the rhythm of your life.</span></h1>
          <p>Find new tracks, follow Vietnamese creators, and save music for every moment.</p>'''

replacement1 = '''          <span className="discover-kicker"><SparklesIcon width={14} height={14} /> MAGISOUND EXCLUSIVE SOUNDSCAPE</span>
          <h1 id="discover-title">Experience the<br /><span>Magic of Every Beat.</span></h1>
          <p>Immerse yourself in high-fidelity streaming, uncover rising creators, and let the magic of music elevate your day.</p>'''

target2 = '''          <div className="discover-proof">
            <span><b>1.2K+</b><small>Vietnamese creators</small></span>
            <span><b>{tracksLoading ? "--" : catalogTrackCount}</b><small>published tracks</small></span>
            <span><b>Every day</b><small>new music added</small></span>
          </div>'''

replacement2 = '''          <div className="discover-proof">
            <span><b>1.2K+</b><small>Talented creators</small></span>
            <span><b>{tracksLoading ? "--" : catalogTrackCount}</b><small>High-res tracks</small></span>
            <span><b>24/7</b><small>Non-stop streaming</small></span>
          </div>'''

target3 = '{heroTrack.creator?.displayName ?? "Unknown Artist"}{heroTrack.album?.title ? ` · ${heroTrack.album.title}` : ""}'
replacement3 = '{heroTrack.creator?.displayName ?? "Unknown Artist"}'

text = text.replace(target1, replacement1)
text = text.replace(target2, replacement2)
text = text.replace(target3, replacement3)

with open('frontend/src/pages/ExplorePage.tsx', 'w', encoding='utf-8') as f:
    f.write(text)
print('Updated ExplorePage.tsx')
