import re

path = 'frontend/src/pages/SearchPage.tsx'
with open(path, 'r', encoding='utf-8') as f:
    c = f.read()

target_matched = """  const matchedAlbums = useMemo(() => {
    if (!query) return [];
    return .filter(
      (a) => a.title.toLowerCase().includes(query) || a.creatorName.toLowerCase().includes(query)
    );
  }, [query]);"""

c = c.replace(target_matched, "")
c = c.replace("matchedAlbums.length + ", "")
c = c.replace('placeholder="Track, album or creator..."', 'placeholder="Track or creator..."')
c = c.replace('Use a title, creator name or album to explore', 'Use a title or creator name to explore')

with open(path, 'w', encoding='utf-8') as f:
    f.write(c)

print('Updated SearchPage.tsx successfully')
