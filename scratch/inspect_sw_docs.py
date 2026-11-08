import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_path = r"C:\Users\lehai\IdeaProjects\SoundWaveProject"

docs_dir = os.path.join(sw_path, "docs")
if os.path.exists(docs_dir):
    print("Files in SoundWaveProject/docs:")
    for root, dirs, files in os.walk(docs_dir):
        for f in files:
            p = os.path.relpath(os.path.join(root, f), docs_dir)
            print(f"  {p}")

diagram_dir = os.path.join(sw_path, "diagram")
if os.path.exists(diagram_dir):
    print("\nFiles in SoundWaveProject/diagram:")
    for f in os.listdir(diagram_dir):
        print(f"  {f}")
