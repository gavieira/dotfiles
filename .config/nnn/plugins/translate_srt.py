#!/usr/bin/env python3
import os
import re
import json
import time
import requests
from concurrent.futures import ThreadPoolExecutor, as_completed

# Configuration
SOURCE_LANG = "en"
TARGET_LANG = "pt"
TRANSLATED_SUFFIX = ".pt.srt"
MAX_WORKERS = 1
LT_URL = "http://localhost:5001/translate"
SLEEP_BETWEEN_REQUESTS = 0.5

def strip_tags(text):
    return re.sub(r"<[^>]+>", "", text)

def find_srt_files(root_dir="."):
    srt_files = []
    for dirpath, _, filenames in os.walk(root_dir):
        for f in filenames:
            if f.endswith(".srt") and not f.endswith(TRANSLATED_SUFFIX):
                full_path = os.path.join(dirpath, f)
                srt_files.append(full_path)
    return srt_files

def translate_line(text):
    if not text.strip():
        return ""
    try:
        response = requests.post(
            LT_URL,
            json={
                "q": text,
                "source": SOURCE_LANG,
                "target": TARGET_LANG,
                "format": "text"
            }
        )
        response.raise_for_status()
        return response.json().get("translatedText", "")
    except Exception as e:
        print(f"Error translating line: {text}\n{e}")
        return text

def translate_srt_file(srt_path):
    translated_path = srt_path.replace(".srt", TRANSLATED_SUFFIX)
    if os.path.exists(translated_path):
        print(f"Skipping {srt_path} (already translated)")
        return

    print(f"Translating {srt_path}")
    with open(srt_path, encoding="utf-8") as f:
        lines = f.read().splitlines()

    output_lines = []
    block = []
    for line in lines + [""]:  # Ensure last block is processed
        if line.strip() == "":
            if len(block) >= 2:
                index = block[0]
                timestamp = block[1]
                text_lines = block[2:]

                output_lines.append(index)
                output_lines.append(timestamp)

                for tline in text_lines:
                    clean_line = strip_tags(tline)
                    translated = translate_line(clean_line)
                    output_lines.append(translated)
                    time.sleep(SLEEP_BETWEEN_REQUESTS)

                output_lines.append("")
            block = []
        else:
            block.append(line)

    with open(translated_path, "w", encoding="utf-8") as f:
        f.write("\n".join(output_lines))
    
    print(f"Finished {srt_path}")

def main():
    srt_files = find_srt_files()
    with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
        futures = {executor.submit(translate_srt_file, srt): srt for srt in srt_files}
        for future in as_completed(futures):
            srt = futures[future]
            try:
                future.result()
            except Exception as e:
                print(f"Error processing {srt}: {e}")

if __name__ == "__main__":
    main()

