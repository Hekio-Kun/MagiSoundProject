import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_fe = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\frontend\src"
ms_fe = r"C:\Users\lehai\IdeaProjects\MagiSoundProject\frontend\src"

def list_files(base_dir):
    res = {}
    for root, dirs, files in os.walk(base_dir):
        for f in files:
            rel = os.path.relpath(os.path.join(root, f), base_dir)
            res[rel] = os.path.join(root, f)
    return res

sw_files = list_files(sw_fe)
ms_files = list_files(ms_fe)

print("=== FRONTEND API CLIENTS ===")
sw_apis = [f for f in sw_files if f.startswith("api")]
ms_apis = [f for f in ms_files if f.startswith("api")]
print("SoundWave APIs:")
for a in sorted(sw_apis):
    print(f"  {a}")
print("\nMagiSound APIs:")
for a in sorted(ms_apis):
    print(f"  {a}")

print("\n=== FRONTEND PAGES ===")
sw_pages = [f for f in sw_files if f.startswith("pages")]
ms_pages = [f for f in ms_files if f.startswith("pages")]
print("SoundWave Pages:")
for p in sorted(sw_pages):
    print(f"  {p}")
print("\nMagiSound Pages:")
for p in sorted(ms_pages):
    print(f"  {p}")

print("\n=== FRONTEND MODALS ===")
sw_modals = [f for f in sw_files if "modals" in f]
ms_modals = [f for f in ms_files if "modals" in f]
print("SoundWave Modals:")
for m in sorted(sw_modals):
    print(f"  {m}")
print("\nMagiSound Modals:")
for m in sorted(ms_modals):
    print(f"  {m}")
