with open(r"frontend/src/app-shell.css", "r", encoding="utf-8") as f:
    lines = f.readlines()

start_idx = None
end_idx = None

for idx, line in enumerate(lines):
    if "3. AppTopBar Component" in line:
        start_idx = idx - 1  # include comment line above
    if start_idx is not None and ".notification-badge {" in line:
        end_idx = idx
        break

print(f"Replacing lines {start_idx+1} to {end_idx+1}")

clean_topbar = """/* --------------------------------------------------------------------------
   3. AppTopBar Component (Sticky Navigation, Search and Account)
   -------------------------------------------------------------------------- */
.app-topbar {
  height: 64px;
  position: sticky;
  top: 0;
  z-index: 35;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid #e4e4e7;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 32px;
  gap: 20px;
}

.topbar-nav-controls {
  display: flex;
  align-items: center;
  gap: 6px;
}

.topbar-nav-btn {
  width: 32px;
  height: 32px;
  display: grid;
  place-items: center;
  border: 1px solid #e4e4e7 !important;
  border-radius: 50%;
  background: #f4f4f5;
  color: #18181b;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-nav-btn:hover {
  background: #e4e4e7;
  color: #000000;
  border-color: #000000 !important;
}

.topbar-search {
  position: relative;
  flex: 1;
  max-width: 480px;
  display: flex;
  align-items: center;
  gap: 10px;
  height: 40px;
  background: #f4f4f5;
  border: 1px solid #e4e4e7 !important;
  border-radius: 20px;
  padding: 0 14px;
  color: #000000;
  transition: all 0.16s ease;
}
.topbar-search:focus-within {
  background: #ffffff;
  border-color: #000000 !important;
  box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.08);
}
.topbar-search svg {
  color: #71717a;
  flex-shrink: 0;
}
.topbar-search input {
  flex: 1;
  width: 100%;
  border: 0 !important;
  outline: none;
  background: transparent;
  color: #000000 !important;
  font-size: 13.5px;
}
.topbar-search input::placeholder {
  color: #71717a;
}

.search-clear-btn {
  border: 0 !important;
  background: none;
  color: #71717a;
  cursor: pointer;
  display: grid;
  place-items: center;
  padding: 2px;
  border-radius: 4px;
}
.search-clear-btn:hover {
  color: #000000;
}

.topbar-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.topbar-upload-btn {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  height: 38px;
  padding: 0 16px;
  border-radius: 20px;
  border: 1px solid #000000 !important;
  background: #000000;
  color: #ffffff !important;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.2s ease;
}
.topbar-upload-btn svg {
  color: #ffffff !important;
}
.topbar-upload-btn:hover {
  background: #27272a;
  color: #ffffff !important;
  border-color: #27272a !important;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
  transform: translateY(-1px);
}

.topbar-bell-btn {
  position: relative;
  width: 38px;
  height: 38px;
  display: grid;
  place-items: center;
  border: 1px solid #e4e4e7 !important;
  border-radius: 12px;
  background: #f4f4f5;
  color: #18181b;
  cursor: pointer;
  transition: all 0.15s ease;
}
.topbar-bell-btn:hover {
  background: #e4e4e7;
  color: #000000;
  border-color: #000000 !important;
}

"""

new_lines = lines[:start_idx] + [clean_topbar] + lines[end_idx:]

with open(r"frontend/src/app-shell.css", "w", encoding="utf-8") as f:
    f.writelines(new_lines)

print("TopBar cleanly replaced!")
