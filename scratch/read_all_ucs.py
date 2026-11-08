import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

art_path = r"C:\Users\lehai\.gemini\antigravity\brain\34d36dea-5e6f-49e8-b757-cd6fafd51a69\all_uc_detailed_specifications.md"

if os.path.exists(art_path):
    with open(art_path, "r", encoding="utf-8") as f:
        lines = f.readlines()
    print("Lines in all_uc_detailed_specifications.md:")
    for l in lines[:60]:
        if "UC-" in l or "Use Case" in l or "#" in l:
            print(l.strip())
