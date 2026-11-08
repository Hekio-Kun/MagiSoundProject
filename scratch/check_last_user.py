import json
import sys

sys.stdout.reconfigure(encoding='utf-8')

with open(r"C:\Users\lehai\.gemini\antigravity\brain\34d36dea-5e6f-49e8-b757-cd6fafd51a69\.system_generated\logs\transcript.jsonl", "r", encoding="utf-8") as f:
    for line in f:
        data = json.loads(line)
        idx = data.get("step_index")
        source = data.get("source")
        step_type = data.get("type")
        if idx is not None and idx >= 1845:
            content_snippet = str(data.get("content", ""))[:200].replace("\n", " ")
            media = data.get("media")
            tool_calls = [tc.get("name") for tc in data.get("tool_calls", [])] if data.get("tool_calls") else None
            print(f"step {idx}: {source} | {step_type} | tc={tool_calls} | media={media} | content={content_snippet}")
