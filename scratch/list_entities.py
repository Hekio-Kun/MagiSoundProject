import os
import re

for root, _, files in os.walk('backend/src/main/java/group03/magisound'):
    for f in files:
        if f.endswith('.java'):
            p = os.path.join(root, f)
            with open(p, 'r', encoding='utf-8') as fh:
                content = fh.read()
                if '@Entity' in content:
                    m_table = re.search(r'@Table\s*\(\s*name\s*=\s*"([^"]+)"', content)
                    tname = m_table.group(1) if m_table else f.replace('.java', '')
                    print(f"{f} -> Table: {tname} (Path: {p})")
