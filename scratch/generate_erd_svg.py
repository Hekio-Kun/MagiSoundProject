import os

def generate_comprehensive_svg():
    # Width 1280, Height 900
    svg = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1300 920" width="100%" height="auto" style="background:#f8fafc; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;">
  <defs>
    <!-- Background Grid -->
    <pattern id="grid" width="25" height="25" patternUnits="userSpaceOnUse">
      <path d="M 25 0 L 0 0 0 25" fill="none" stroke="#cbd5e1" stroke-width="0.6"/>
    </pattern>

    <!-- Crow's Foot Markers -->
    <!-- Mandatory Exactly One: || -->
    <marker id="cf-mand-one" viewBox="0 0 24 24" refX="12" refY="12" markerWidth="14" markerHeight="14" orient="auto">
      <line x1="8" y1="3" x2="8" y2="21" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
      <line x1="16" y1="3" x2="16" y2="21" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
    </marker>

    <!-- Optional One: o| -->
    <marker id="cf-opt-one" viewBox="0 0 24 24" refX="16" refY="12" markerWidth="14" markerHeight="14" orient="auto">
      <circle cx="7" cy="12" r="4.5" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
      <line x1="16" y1="3" x2="16" y2="21" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
    </marker>

    <!-- Zero or Many: o< (Crow's foot with circle) -->
    <marker id="cf-zero-many" viewBox="0 0 24 24" refX="22" refY="12" markerWidth="16" markerHeight="16" orient="auto">
      <circle cx="6" cy="12" r="4" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
      <line x1="10" y1="12" x2="22" y2="12" stroke="#0f172a" stroke-width="2"/>
      <path d="M 12 12 L 22 3 M 12 12 L 22 21" fill="none" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
    </marker>

    <!-- Mandatory Many: |< (Crow's foot with bar) -->
    <marker id="cf-mand-many" viewBox="0 0 24 24" refX="22" refY="12" markerWidth="16" markerHeight="16" orient="auto">
      <line x1="6" y1="4" x2="6" y2="20" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
      <line x1="6" y1="12" x2="22" y2="12" stroke="#0f172a" stroke-width="2"/>
      <path d="M 10 12 L 22 3 M 10 12 L 22 21" fill="none" stroke="#0f172a" stroke-width="2.2" stroke-linecap="round"/>
    </marker>

    <!-- Filter for subtle drop shadow -->
    <filter id="shadow" x="-3%" y="-3%" width="108%" height="108%">
      <feDropShadow dx="1" dy="2" stdDeviation="2" flood-color="#000000" flood-opacity="0.08"/>
    </filter>
  </defs>

  <!-- Background with Canvas Grid -->
  <rect width="100%" height="100%" fill="url(#grid)"/>

  <!-- Canvas Header -->
  <rect x="25" y="15" width="1250" height="42" rx="6" fill="#0f172a"/>
  <text x="650" y="41" text-anchor="middle" fill="#ffffff" font-size="16" font-weight="700" letter-spacing="1">
    MAGISOUND SYSTEM — ENTITY RELATIONSHIP DIAGRAM (CHEN &amp; CROW'S FOOT NOTATION)
  </text>

  <!-- ==================== CONNECTING LINES (DRAWN BEHIND BOXES) ==================== -->
  <g stroke="#334155" stroke-width="1.8" fill="none">
    <!-- 1. STAFF_ROLE -> HAS_ROLE -> STAFF -->
    <line x1="190" y1="125" x2="190" y2="155" marker-start="url(#cf-mand-one)"/>
    <line x1="190" y1="205" x2="190" y2="235" marker-end="url(#cf-zero-many)"/>

    <!-- 2. STAFF -> RECEIVES -> NOTIFICATION -->
    <line x1="190" y1="305" x2="190" y2="340" marker-start="url(#cf-opt-one)"/>
    <line x1="190" y1="390" x2="190" y2="425" marker-end="url(#cf-zero-many)"/>

    <!-- 3. USER -> RECEIVES -> NOTIFICATION -->
    <line x1="190" y1="620" x2="190" y2="575" marker-start="url(#cf-mand-one)"/>
    <line x1="190" y1="525" x2="190" y2="485" marker-end="url(#cf-zero-many)"/>

    <!-- 4. STAFF -> APPROVES -> TRACK_SUBMISSION -->
    <path d="M 280 255 L 350 255 L 350 170 L 375 170" marker-start="url(#cf-opt-one)"/>
    <line x1="465" y1="170" x2="520" y2="170" marker-end="url(#cf-zero-many)"/>

    <!-- 5. USER -> SUBMITS -> TRACK_SUBMISSION -->
    <path d="M 280 635 L 320 635 L 320 120 L 375 120" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="120" x2="520" y2="145" marker-end="url(#cf-zero-many)"/>

    <!-- 6. STAFF -> MAINTAINS -> OFFICIAL_LYRIC -->
    <path d="M 280 275 L 340 275 L 340 235 L 375 235" marker-start="url(#cf-opt-one)"/>
    <line x1="465" y1="235" x2="520" y2="235" marker-end="url(#cf-zero-many)"/>

    <!-- 7. USER -> MARKS -> FAVORITE -->
    <path d="M 280 645 L 330 645 L 330 325 L 375 325" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="325" x2="520" y2="325" marker-end="url(#cf-zero-many)"/>

    <!-- 8. USER -> WRITES -> PERSONAL_LYRIC -->
    <path d="M 280 655 L 340 655 L 340 415 L 375 415" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="415" x2="520" y2="415" marker-end="url(#cf-zero-many)"/>

    <!-- 9. USER -> OWNS -> PLAYLIST -->
    <path d="M 280 665 L 350 665 L 350 505 L 375 505" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="505" x2="520" y2="505" marker-end="url(#cf-zero-many)"/>

    <!-- 10. USER -> LISTENS -> LISTENING_HISTORY -->
    <path d="M 280 675 L 360 675 L 360 595 L 375 595" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="595" x2="520" y2="595" marker-end="url(#cf-zero-many)"/>

    <!-- 11. USER -> SUBMITS -> CONTENT_REPORT -->
    <path d="M 280 685 L 370 685 L 370 675 L 375 675" marker-start="url(#cf-mand-one)"/>
    <line x1="465" y1="675" x2="520" y2="675" marker-end="url(#cf-zero-many)"/>

    <!-- 12. STAFF -> HANDLES -> CONTENT_REPORT -->
    <path d="M 190 305 L 190 735 L 375 735" marker-start="url(#cf-opt-one)"/>
    <path d="M 465 735 L 500 735 L 500 705 L 520 705" marker-end="url(#cf-zero-many)"/>

    <!-- ==================== CENTER -> RIGHT (TO TRACK) ==================== -->
    <!-- 13. TRACK_SUBMISSION -> HAS -> TRACK -->
    <line x1="720" y1="155" x2="780" y2="155" marker-start="url(#cf-mand-one)"/>
    <path d="M 870 155 L 940 155 L 940 430" marker-end="url(#cf-mand-one)"/>

    <!-- 14. OFFICIAL_LYRIC -> HAS -> TRACK -->
    <line x1="720" y1="235" x2="780" y2="235" marker-start="url(#cf-mand-one)"/>
    <path d="M 870 235 L 930 235 L 930 430" marker-end="url(#cf-mand-one)"/>

    <!-- 15. FAVORITE -> INCLUDES -> TRACK -->
    <line x1="720" y1="325" x2="780" y2="325" marker-start="url(#cf-mand-many)"/>
    <path d="M 870 325 L 920 325 L 920 430" marker-end="url(#cf-mand-one)"/>

    <!-- 16. PERSONAL_LYRIC -> HAS -> TRACK -->
    <line x1="720" y1="415" x2="780" y2="415" marker-start="url(#cf-mand-many)"/>
    <path d="M 870 415 L 890 415 L 890 450 L 910 450" marker-end="url(#cf-mand-one)"/>

    <!-- 17. PLAYLIST -> CONTAINS -> TRACK -->
    <line x1="720" y1="505" x2="780" y2="505" marker-start="url(#cf-zero-many)"/>
    <line x1="870" y1="505" x2="910" y2="505" marker-end="url(#cf-zero-many)"/>

    <!-- 18. LISTENING_HISTORY -> RECORDS -> TRACK -->
    <line x1="720" y1="595" x2="780" y2="595" marker-start="url(#cf-mand-many)"/>
    <path d="M 870 595 L 890 595 L 890 560 L 910 560" marker-end="url(#cf-mand-one)"/>

    <!-- 19. CONTENT_REPORT -> CONCERNS -> TRACK -->
    <line x1="720" y1="685" x2="780" y2="685" marker-start="url(#cf-mand-many)"/>
    <path d="M 870 685 L 930 685 L 930 610" marker-end="url(#cf-mand-one)"/>

    <!-- 20. GENRE -> CATEGORIZES -> TRACK -->
    <line x1="1025" y1="285" x2="1025" y2="330" marker-start="url(#cf-mand-one)"/>
    <line x1="1025" y1="380" x2="1025" y2="430" marker-end="url(#cf-zero-many)"/>
  </g>

  <!-- ==================== LEFT COLUMN: ENTITIES ==================== -->
  <!-- STAFF_ROLE -->
  <g filter="url(#shadow)">
    <rect x="100" y="75" width="180" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="190" y="105" text-anchor="middle" fill="#0f172a" font-size="14" font-weight="700">STAFF_ROLE</text>
  </g>

  <!-- STAFF -->
  <g filter="url(#shadow)">
    <rect x="100" y="235" width="180" height="70" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="190" y="275" text-anchor="middle" fill="#0f172a" font-size="16" font-weight="700">STAFF</text>
  </g>

  <!-- NOTIFICATION -->
  <g filter="url(#shadow)">
    <rect x="100" y="425" width="180" height="60" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="190" y="460" text-anchor="middle" fill="#0f172a" font-size="14" font-weight="700">NOTIFICATION</text>
  </g>

  <!-- USER -->
  <g filter="url(#shadow)">
    <rect x="100" y="620" width="180" height="70" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="190" y="660" text-anchor="middle" fill="#0f172a" font-size="16" font-weight="700">USER</text>
  </g>

  <!-- ==================== CENTER COLUMN: 7 BUSINESS ENTITIES ==================== -->
  <!-- 1. TRACK_SUBMISSION -->
  <g filter="url(#shadow)">
    <rect x="520" y="130" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="160" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">TRACK_SUBMISSION</text>
  </g>

  <!-- 2. OFFICIAL_LYRIC -->
  <g filter="url(#shadow)">
    <rect x="520" y="210" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="240" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">OFFICIAL_LYRIC</text>
  </g>

  <!-- 3. FAVORITE (Weak/Associative Entity: Double Border) -->
  <g filter="url(#shadow)">
    <rect x="520" y="300" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <rect x="524" y="304" width="192" height="42" rx="2" fill="none" stroke="#0f172a" stroke-width="1.5"/>
    <text x="620" y="330" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">FAVORITE</text>
  </g>

  <!-- 4. PERSONAL_LYRIC -->
  <g filter="url(#shadow)">
    <rect x="520" y="390" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="420" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">PERSONAL_LYRIC</text>
  </g>

  <!-- 5. PLAYLIST -->
  <g filter="url(#shadow)">
    <rect x="520" y="480" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="510" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">PLAYLIST</text>
  </g>

  <!-- 6. LISTENING_HISTORY -->
  <g filter="url(#shadow)">
    <rect x="520" y="570" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="600" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">LISTENING_HISTORY</text>
  </g>

  <!-- 7. CONTENT_REPORT -->
  <g filter="url(#shadow)">
    <rect x="520" y="660" width="200" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="620" y="690" text-anchor="middle" fill="#0f172a" font-size="13" font-weight="700">CONTENT_REPORT</text>
  </g>

  <!-- ==================== RIGHT COLUMN: CATALOG ENTITIES ==================== -->
  <!-- GENRE -->
  <g filter="url(#shadow)">
    <rect x="935" y="235" width="180" height="50" rx="3" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <text x="1025" y="265" text-anchor="middle" fill="#0f172a" font-size="14" font-weight="700">GENRE</text>
  </g>

  <!-- TRACK (Central Hub) -->
  <g filter="url(#shadow)">
    <rect x="910" y="430" width="230" height="180" rx="4" fill="#ffffff" stroke="#0f172a" stroke-width="2.5"/>
    <text x="1025" y="525" text-anchor="middle" fill="#0f172a" font-size="22" font-weight="800" letter-spacing="1">TRACK</text>
    <text x="1025" y="550" text-anchor="middle" fill="#64748b" font-size="11" font-weight="600">(Core Catalog Entity)</text>
  </g>

  <!-- ==================== RELATIONSHIPS: DIAMONDS ==================== -->
  <!-- Helper macro for diamond: center (cx, cy), width 90, height 44 -->
'''

    # Diamond generator
    def diamond(name, cx, cy, label):
        return f'''
  <g filter="url(#shadow)">
    <polygon points="{cx},{cy-22} {cx+45},{cy} {cx},{cy+22} {cx-45},{cy}" fill="#f0f9ff" stroke="#0284c7" stroke-width="1.8"/>
    <text x="{cx}" y="{cy+4}" text-anchor="middle" fill="#0369a1" font-size="9.5" font-weight="700" letter-spacing="0.5">{label}</text>
  </g>'''

    diamonds = [
        # Left relationships
        ("has_role", 190, 180, "HAS_ROLE"),
        ("staff_recv", 190, 365, "RECEIVES"),
        ("user_recv", 190, 550, "RECEIVES"),

        # Left to Center relationships
        ("submits_submission", 420, 120, "SUBMITS"),
        ("approves_submission", 420, 170, "APPROVES"),
        ("maintains_lyric", 420, 235, "MAINTAINS"),
        ("marks_fav", 420, 325, "MARKS"),
        ("writes_lyric", 420, 415, "WRITES"),
        ("owns_playlist", 420, 505, "OWNS"),
        ("listens_hist", 420, 595, "LISTENS"),
        ("submits_rep", 420, 675, "SUBMITS"),
        ("handles_rep", 420, 735, "HANDLES"),

        # Center to Track relationships
        ("has_sub", 825, 155, "HAS"),
        ("has_off", 825, 235, "HAS"),
        ("includes_fav", 825, 325, "INCLUDES"),
        ("has_pers", 825, 415, "HAS"),
        ("contains_play", 825, 505, "CONTAINS"),
        ("records_hist", 825, 595, "RECORDS"),
        ("concerns_rep", 825, 685, "CONCERNS"),

        # Genre to Track
        ("categorizes", 1025, 355, "CATEGORIZES")
    ]

    for d in diamonds:
        svg += diamond(*d)

    # Legend / Key in bottom right
    svg += '''
  <!-- Legend -->
  <g transform="translate(40, 790)" filter="url(#shadow)">
    <rect width="1220" height="95" rx="5" fill="#ffffff" stroke="#cbd5e1" stroke-width="1.5"/>
    <text x="20" y="24" fill="#0f172a" font-size="12" font-weight="700">NOTATION KEY &amp; CARDINALITY GUIDE (PETER CHEN + CROW'S FOOT):</text>
    
    <!-- Legend item 1 -->
    <rect x="20" y="38" width="50" height="22" fill="#ffffff" stroke="#0f172a" stroke-width="1.5"/>
    <text x="80" y="54" fill="#334155" font-size="11"><b>Entity</b> (Rectangle)</text>

    <!-- Legend item 2 -->
    <rect x="230" y="38" width="50" height="22" fill="#ffffff" stroke="#0f172a" stroke-width="2"/>
    <rect x="233" y="41" width="44" height="16" fill="none" stroke="#0f172a" stroke-width="1"/>
    <text x="290" y="54" fill="#334155" font-size="11"><b>Weak Entity</b> (Double Box - FAVORITE)</text>

    <!-- Legend item 3 -->
    <polygon points="560,37 575,49 560,61 545,49" fill="#f0f9ff" stroke="#0284c7" stroke-width="1.5"/>
    <text x="585" y="54" fill="#334155" font-size="11"><b>Relationship</b> (Diamond)</text>

    <!-- Legend item 4 -->
    <line x1="750" y1="49" x2="790" y2="49" stroke="#0f172a" stroke-width="1.8" marker-end="url(#cf-mand-one)"/>
    <text x="805" y="54" fill="#334155" font-size="11"><b>Mandatory One</b> (||)</text>

    <!-- Legend item 5 -->
    <line x1="940" y1="49" x2="980" y2="49" stroke="#0f172a" stroke-width="1.8" marker-end="url(#cf-zero-many)"/>
    <text x="995" y="54" fill="#334155" font-size="11"><b>Zero or Many</b> (o&lt;)</text>

    <!-- Legend item 6 -->
    <text x="20" y="80" fill="#64748b" font-size="10.5">
      * <b>Scope Rule:</b> ALBUM entity excluded to conform strictly with MagiSound 46 Use Cases. Both line ends explicitly display Crow's Foot cardinality.
    </text>
  </g>
</svg>'''
    return svg

def generate_conceptual_svg():
    # Image 1 structure: 7 boxes, 8 diamonds
    svg = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 950 550" width="100%" height="auto" style="background:#f8fafc; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;">
  <defs>
    <pattern id="grid2" width="20" height="20" patternUnits="userSpaceOnUse">
      <path d="M 20 0 L 0 0 0 20" fill="none" stroke="#cbd5e1" stroke-width="0.6"/>
    </pattern>
    <filter id="shadow2" x="-4%" y="-4%" width="108%" height="108%">
      <feDropShadow dx="1" dy="2" stdDeviation="2" flood-color="#000000" flood-opacity="0.1"/>
    </filter>
  </defs>

  <rect width="100%" height="100%" fill="url(#grid2)"/>

  <!-- Title -->
  <rect x="25" y="15" width="900" height="38" rx="5" fill="#1e3a8a"/>
  <text x="475" y="39" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="700">
    MAGISOUND — CONCEPTUAL CORE ERD (CHEN NOTATION ARCHITECTURE)
  </text>

  <!-- Connectors -->
  <g stroke="#2563eb" stroke-width="2" fill="none">
    <!-- User -> D1 -> Playlist -->
    <path d="M 160 260 L 160 115 L 235 115"/>
    <line x1="315" y1="115" x2="390" y2="115"/>

    <!-- User -> D2 -> Track -->
    <line x1="160" y1="260" x2="235" y2="260"/>
    <line x1="315" y1="260" x2="390" y2="260"/>

    <!-- User -> D3 -> ListeningHistory -->
    <path d="M 160 260 L 160 415 L 235 415"/>
    <line x1="315" y1="415" x2="390" y2="415"/>

    <!-- Playlist -> D4 -> Track -->
    <line x1="470" y1="140" x2="470" y2="185"/>
    <line x1="470" y1="235" x2="470" y2="235"/>
    <line x1="470" y1="235" x2="470" y2="235"/>
    <line x1="470" y1="235" x2="470" y2="235"/>
    <line x1="470" y1="235" x2="470" y2="235"/>
    <line x1="470" y1="210" x2="470" y2="235"/>

    <!-- Track -> D5 -> ListeningHistory -->
    <line x1="470" y1="285" x2="470" y2="335"/>
    <line x1="470" y1="385" x2="470" y2="390"/>

    <!-- Track -> D6 -> Genre -->
    <line x1="550" y1="260" x2="625" y2="260"/>
    <line x1="705" y1="260" x2="750" y2="260"/>

    <!-- ListeningHistory -> D7 -> ContentReport -->
    <line x1="550" y1="415" x2="625" y2="415"/>
    <line x1="705" y1="415" x2="750" y2="415"/>

    <!-- ContentReport -> D8 -> Staff -->
    <path d="M 830 415 L 875 415 L 875 335"/>
    <line x1="875" y1="285" x2="875" y2="285"/>
    <line x1="875" y1="285" x2="875" y2="260"/>
  </g>

  <!-- 7 Entities (Rectangles with soft blue fill like Image 1) -->
  <!-- 1. USER (Far Left) -->
  <g filter="url(#shadow2)">
    <rect x="40" y="235" width="120" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="100" y="265" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">USER</text>
  </g>

  <!-- 2. PLAYLIST (Top Center) -->
  <g filter="url(#shadow2)">
    <rect x="390" y="90" width="160" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="470" y="120" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">PLAYLIST</text>
  </g>

  <!-- 3. TRACK (Center) -->
  <g filter="url(#shadow2)">
    <rect x="390" y="235" width="160" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="470" y="265" text-anchor="middle" fill="#ffffff" font-size="14" font-weight="800">TRACK</text>
  </g>

  <!-- 4. LISTENING_HISTORY (Bottom Center) -->
  <g filter="url(#shadow2)">
    <rect x="390" y="390" width="160" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="470" y="420" text-anchor="middle" fill="#ffffff" font-size="11.5" font-weight="700">LISTENING_HISTORY</text>
  </g>

  <!-- 5. GENRE (Mid Right Top) -->
  <g filter="url(#shadow2)">
    <rect x="750" y="235" width="150" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="825" y="265" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">GENRE</text>
  </g>

  <!-- 6. CONTENT_REPORT (Mid Right Bottom) -->
  <g filter="url(#shadow2)">
    <rect x="750" y="390" width="150" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="825" y="420" text-anchor="middle" fill="#ffffff" font-size="12" font-weight="700">CONTENT_REPORT</text>
  </g>

  <!-- 7. STAFF (Far Right Top) -->
  <g filter="url(#shadow2)">
    <rect x="800" y="100" width="130" height="50" rx="3" fill="#3b82f6" stroke="#1d4ed8" stroke-width="2"/>
    <text x="865" y="130" text-anchor="middle" fill="#ffffff" font-size="13" font-weight="700">STAFF</text>
  </g>

  <!-- 8 Diamonds (Relationships) -->
'''

    def d_small(cx, cy, label):
        return f'''
  <g filter="url(#shadow2)">
    <polygon points="{cx},{cy-18} {cx+40},{cy} {cx},{cy+18} {cx-40},{cy}" fill="#ffffff" stroke="#2563eb" stroke-width="1.8"/>
    <text x="{cx}" y="{cy+4}" text-anchor="middle" fill="#1e3a8a" font-size="9" font-weight="700">{label}</text>
  </g>'''

    diamonds2 = [
        (275, 115, "CREATES"),
        (275, 260, "UPLOADS"),
        (275, 415, "LISTENS"),
        (470, 185, "CONTAINS"),
        (470, 335, "RECORDS"),
        (665, 260, "BELONGS_TO"),
        (665, 415, "TRIGGERS"),
        (875, 285, "HANDLES")
    ]

    for d in diamonds2:
        svg += d_small(*d)

    svg += '</svg>'
    return svg

if __name__ == '__main__':
    svg_comp = generate_comprehensive_svg()
    svg_conc = generate_conceptual_svg()
    
    os.makedirs(r'c:\Users\lehai\IdeaProjects\MagiSoundProject\docs\diagrams', exist_ok=True)
    with open(r'c:\Users\lehai\IdeaProjects\MagiSoundProject\docs\diagrams\MagiSound_ERD_Comprehensive.svg', 'w', encoding='utf-8') as f:
        f.write(svg_comp)
    with open(r'c:\Users\lehai\IdeaProjects\MagiSoundProject\docs\diagrams\MagiSound_ERD_Conceptual_Core.svg', 'w', encoding='utf-8') as f:
        f.write(svg_conc)
    print("Generated SVG files successfully!")
