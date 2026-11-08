import os
import sys

sys.stdout.reconfigure(encoding='utf-8')

sw_svc = r"C:\Users\lehai\IdeaProjects\SoundWaveProject\backend\src\main\java\groupone\soundwaveproject\admin\service\AdminStatisticsService.java"
with open(sw_svc, "r", encoding="utf-8") as f:
    print(f.read())
