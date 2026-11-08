path = "backend/src/test/java/group03/magisound/catalog/service/TrackCatalogServiceTest.java"
with open(path, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = []
for i, line in enumerate(lines):
    if "genre," in line:
        new_lines.append(line)
        if i + 1 < len(lines) and lines[i+1].strip() == "null,":
            continue
    elif line.strip() == "null," and i > 0 and "genre," in lines[i-1]:
        continue
    else:
        new_lines.append(line)

with open(path, "w", encoding="utf-8") as f:
    f.writelines(new_lines)
print("Updated TrackCatalogServiceTest.java")
