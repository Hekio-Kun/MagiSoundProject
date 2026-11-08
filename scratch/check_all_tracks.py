import urllib.request, json, sys

sys.stdout.reconfigure(encoding='utf-8')
url = 'http://localhost:8088/api/v1/tracks?size=100'
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
with urllib.request.urlopen(req) as resp:
    data = json.loads(resp.read().decode('utf-8'))
    content = data.get('content', [])
    print(f'Total tracks: {len(content)}')
    uploaders = {}
    for item in content:
        c = item.get('creator') or {}
        uid = c.get('userId')
        name = c.get('displayName')
        uploaders[uid] = uploaders.get(uid, 0) + 1
        print(f"Track {item.get('id'):2d}: '{item.get('title')}' -> Uploader: {uid} ('{name}')")
    print('\nDistinct uploaders:', uploaders)
