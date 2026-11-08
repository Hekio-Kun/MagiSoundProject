import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_ent = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\backend\src\main\java\groupone\soundwaveproject"
ms_ent = r"C:\Users\lehai\IdeaProjects\MagiSoundProject\backend\src\main\java\group03\magisound"

def find_entities(base):
    entities = {}
    for root, dirs, files in os.walk(base):
        for f in files:
            if f.endswith(".java"):
                p = os.path.join(root, f)
                with open(p, "r", encoding="utf-8", errors="ignore") as file:
                    content = file.read()
                    if "@Entity" in content or "@Table" in content:
                        entities[f] = p
    return entities

sw_entities = find_entities(sw_ent)
ms_entities = find_entities(ms_ent)

print("=== ENTITIES ===")
print("SoundWave Entities:")
for e in sorted(sw_entities.keys()):
    print(f"  {e}")

print("\nMagiSound Entities:")
for e in sorted(ms_entities.keys()):
    print(f"  {e}")
