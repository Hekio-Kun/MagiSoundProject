import urllib.request, json, sys

sys.stdout.reconfigure(encoding='utf-8')
for uid in [10, 11, 12, 13, 15, 16, 17, 19]:
    url = f"http://localhost:8088/api/v1/profile/{uid}"
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode('utf-8'))
        print(f"User {uid:2d}: {data.get('displayName')} (@{data.get('username')}) - {data.get('email')}")
