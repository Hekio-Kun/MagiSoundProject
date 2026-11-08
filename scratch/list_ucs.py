import os
import sys
import re

sys.stdout.reconfigure(encoding='utf-8')

art_path = r"C:\Users\lehai\.gemini\antigravity\brain\34d36dea-5e6f-49e8-b757-cd6fafd51a69\all_uc_detailed_specifications.md"

with open(art_path, "r", encoding="utf-8") as f:
    text = f.read()

headings = re.findall(r'(###\s+UC-\d+.*)', text)
print(f"Total UCs found: {len(headings)}")
for h in headings:
    print(h)
