# 1. Fix frontend/src/api/track.ts
path_track = "frontend/src/api/track.ts"
with open(path_track, "r", encoding="utf-8") as f:
    c = f.read()

c = c.replace("  albumId?: number;\n  albumTitle?: string;\nalbumTitle?: string;\n", "  albumId?: number;\n  albumTitle?: string;\n")
with open(path_track, "w", encoding="utf-8") as f:
    f.write(c)
print("Fixed api/track.ts")

# 2. Fix frontend/src/types.ts
path_types = "frontend/src/types.ts"
with open(path_types, "r", encoding="utf-8") as f:
    c = f.read()

old_notif = """export type NotificationItem = {
  id: number;
  userId: number;
  type: string;
  title: string;
  message: string;
  targetType?: string;
  targetId?: string;
  isRead: boolean;
  createdAt: string;
};"""

new_notif = """export type NotificationItem = {
  id: number;
  userId: number;
  type: string;
  title: string;
  message: string;
  targetType?: string;
  targetId?: string;
  navigationUrl?: string;
  isRead: boolean;
  createdAt: string;
};"""

c = c.replace(old_notif, new_notif)
with open(path_types, "w", encoding="utf-8") as f:
    f.write(c)
print("Fixed types.ts")

# 3. Fix StudioPage.tsx
path_studio = "frontend/src/pages/StudioPage.tsx"
with open(path_studio, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_lines = []
skip = False
for line in lines:
    if "const [deleteConfirmAlbum" in line or "// Load albums from Backend API" in line:
        skip = True
    if skip and "// Load data from Backend API" in line:
        skip = False
    if skip:
        continue
    new_lines.append(line)

with open(path_studio, "w", encoding="utf-8") as f:
    f.writelines(new_lines)
print("Fixed StudioPage.tsx")
