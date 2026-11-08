import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_backend = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\backend\src\main\java\groupone\soundwaveproject"

packages = ["favorite", "report", "admin", "search", "lyric", "catalog"]
for p in packages:
    pkg_dir = os.path.join(sw_backend, p)
    if os.path.exists(pkg_dir):
        print(f"\n=== Package: {p} ===")
        for root, dirs, files in os.walk(pkg_dir):
            for f in files:
                rel = os.path.relpath(os.path.join(root, f), pkg_dir)
                print(f"  {rel}")
