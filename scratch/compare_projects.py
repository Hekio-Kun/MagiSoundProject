import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_base = r'C:\Users\lehai\IdeaProjects\SoundWaveProject'
ms_base = r'C:\Users\lehai\IdeaProjects\MagiSoundProject'

def find_files(base, sub):
    target = os.path.join(base, sub)
    if not os.path.exists(target):
        return []
    res = []
    for root, dirs, files in os.walk(target):
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, target)
            res.append(rel)
    return sorted(res)

sw_be = find_files(sw_base, r'backend\src\main\java\groupone\soundwaveproject')
ms_be = find_files(ms_base, r'backend\src\main\java\group03\magisound')

print("=== BACKEND FILES ===")
print(f"SoundWave BE files: {len(sw_be)}")
print(f"MagiSound BE files: {len(ms_be)}")

# Let's categorize BE files: controllers, services, repositories, entities
def categorize(files):
    controllers = [f for f in files if 'Controller' in f or 'controller' in f.lower()]
    services = [f for f in files if 'Service' in f or 'service' in f.lower()]
    repositories = [f for f in files if 'Repository' in f or 'repository' in f.lower()]
    entities = [f for f in files if 'entity' in f.lower() or 'model' in f.lower()]
    return controllers, services, repositories, entities

sw_c, sw_s, sw_r, sw_e = categorize(sw_be)
ms_c, ms_s, ms_r, ms_e = categorize(ms_be)

print(f"\n--- SoundWave Controllers ({len(sw_c)}) ---")
for c in sw_c:
    print("  ", c)

print(f"\n--- MagiSound Controllers ({len(ms_c)}) ---")
for c in ms_c:
    print("  ", c)

print(f"\n--- SoundWave Entities ({len(sw_e)}) ---")
for e in sw_e:
    print("  ", e)

print(f"\n--- MagiSound Entities ({len(ms_e)}) ---")
for e in ms_e:
    print("  ", e)

sw_pages = find_files(sw_base, r'frontend\src\pages')
ms_pages = find_files(ms_base, r'frontend\src\pages')
print(f"\n--- SoundWave Pages ({len(sw_pages)}) ---")
for p in sw_pages:
    print("  ", p)

print(f"\n--- MagiSound Pages ({len(ms_pages)}) ---")
for p in ms_pages:
    print("  ", p)

sw_modals = find_files(sw_base, r'frontend\src\components\modals')
ms_modals = find_files(ms_base, r'frontend\src\components\modals')
print(f"\n--- SoundWave Modals ({len(sw_modals)}) ---")
for m in sw_modals:
    print("  ", m)

print(f"\n--- MagiSound Modals ({len(ms_modals)}) ---")
for m in ms_modals:
    print("  ", m)
