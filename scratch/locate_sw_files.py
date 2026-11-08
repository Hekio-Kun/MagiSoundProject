import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_backend = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\backend\src\main\java"

targets = ["Favorite", "ContentReport", "StaffController", "Lyric", "Search"]
for root, dirs, files in os.walk(sw_backend):
    for f in files:
        if any(t.lower() in f.lower() for t in targets):
            rel = os.path.relpath(os.path.join(root, f), sw_backend)
            print(f"  {rel}")
