with open('frontend/src/pages/SearchPage.tsx', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    'const quickSearches = ["Minh An", "Mưa", "Biển", "Acoustic"];',
    'const quickSearches = ["Sơn Tùng M-TP", "HIEUTHUHAI", "MCK", "YOASOBI", "Pop", "Acoustic"];'
)

content = content.replace(
    '<button onClick={() => setSearchTerm("Minh An")}>Explore Minh An</button>',
    '<button onClick={() => setSearchTerm("Sơn Tùng M-TP")}>Explore Sơn Tùng M-TP</button>'
)

with open('frontend/src/pages/SearchPage.tsx', 'w', encoding='utf-8', newline='\r\n') as f:
    f.write(content)

print('Updated SearchPage.tsx successfully!')
