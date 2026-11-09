import subprocess, json, sys

sys.stdout.reconfigure(encoding='utf-8')

sql = "SELECT id, title, slug, audio_url, cover_url FROM tracks ORDER BY id;"
cmd = [r'C:\Program Files\PostgreSQL\18\bin\psql.exe', '-h', '127.0.0.1', '-U', 'postgres', '-d', 'magisound', '-p', '5432', '-t', '-A', '-F', '|||', '-c', sql]
p = subprocess.run(cmd, env={'PGPASSWORD': 'postgres'}, capture_output=True, text=True)

lines = p.stdout.strip().split('\n')
print(f'Total tracks in local DB: {len(lines)}')
for line in lines[:15]:
    parts = line.split('|||')
    if len(parts) >= 5:
        tid, title, slug, audio_url, cover_url = parts[:5]
        print(f"ID {tid:2s} | '{title}' | Audio: {audio_url[:50]}... | Cover: {cover_url[:50]}...")
