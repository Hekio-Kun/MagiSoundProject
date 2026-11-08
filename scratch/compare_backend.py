import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_backend = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\backend\src\main\java"
ms_backend = r"C:\Users\lehai\IdeaProjects\MagiSoundProject\backend\src\main\java"

sw_controllers = []
for root, dirs, files in os.walk(sw_backend):
    for f in files:
        if "Controller.java" in f:
            sw_controllers.append(f)

ms_controllers = []
for root, dirs, files in os.walk(ms_backend):
    for f in files:
        if "Controller.java" in f:
            ms_controllers.append(f)

print("=== BACKEND CONTROLLERS ===")
print("SoundWave controllers:")
for c in sorted(sw_controllers):
    print(f"  {c}")

print("\nMagiSound controllers:")
for c in sorted(ms_controllers):
    print(f"  {c}")

sw_services = []
for root, dirs, files in os.walk(sw_backend):
    for f in files:
        if "Service.java" in f or "ServiceImpl.java" in f:
            sw_services.append(f)

ms_services = []
for root, dirs, files in os.walk(ms_backend):
    for f in files:
        if "Service.java" in f or "ServiceImpl.java" in f:
            ms_services.append(f)

print("\n=== BACKEND SERVICES ===")
print("SoundWave services:")
for s in sorted(sw_services):
    print(f"  {s}")

print("\nMagiSound services:")
for s in sorted(ms_services):
    print(f"  {s}")
