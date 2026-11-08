import os
import re

for root, _, files in os.walk('backend/src/main/java/group03/magisound'):
    for f in files:
        if f.endswith('.java'):
            p = os.path.join(root, f)
            with open(p, 'r', encoding='utf-8') as fh:
                content = fh.read()
                if '@Entity' in content:
                    jt = re.findall(r'@JoinTable\s*\([^)]+\)', content, re.DOTALL)
                    fk = re.findall(r'@JoinColumn\s*\([^)]+\)', content, re.DOTALL)
                    if jt or fk:
                        print(f"=== {f} ===")
                        for item in jt:
                            print("  JoinTable:", " ".join(item.split()))
                        for item in fk:
                            print("  JoinColumn:", " ".join(item.split()))
