# Fix TrackCatalogService.java
path_tcs = "backend/src/main/java/group03/magisound/catalog/service/TrackCatalogService.java"
with open(path_tcs, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if "t.getAlbum()" in line:
        # replace the previous line ending with ) instead of ||
        if new_lines and "||" in new_lines[-1]:
            new_lines[-1] = new_lines[-1].rstrip("\r\n").rstrip(" ")
            if new_lines[-1].endswith("||"):
                new_lines[-1] = new_lines[-1][:-2].rstrip(" ") + ")\n"
            else:
                new_lines[-1] = new_lines[-1] + "\n"
        continue
    new_lines.append(line)

with open(path_tcs, "w", encoding="utf-8") as f:
    f.writelines(new_lines)
print("Updated TrackCatalogService.java")

# Fix StudioTrackService.java
path_sts = "backend/src/main/java/group03/magisound/studio/service/StudioTrackService.java"
with open(path_sts, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = [l for l in lines if "Album oldAlbum" not in l]
with open(path_sts, "w", encoding="utf-8") as f:
    f.writelines(new_lines)
print("Updated StudioTrackService.java")

# Fix DemoCatalogInitializer.java
path_dci = "backend/src/main/java/group03/magisound/config/DemoCatalogInitializer.java"
with open(path_dci, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = []
for i, line in enumerate(lines):
    if "popGenre," in line:
        new_lines.append(line)
        # if next line is null,, skip it
        if i + 1 < len(lines) and lines[i+1].strip() == "null,":
            continue
    elif line.strip() == "null," and i > 0 and "popGenre," in lines[i-1]:
        continue
    else:
        new_lines.append(line)

with open(path_dci, "w", encoding="utf-8") as f:
    f.writelines(new_lines)
print("Updated DemoCatalogInitializer.java")
