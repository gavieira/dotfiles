#!/usr/bin/env python3
import os
import re
import json
import time
import requests
import signal
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

# Configuration
SOURCE_LANG = "en"
TARGET_LANG = "pt"
SOURCE_SUFFIX = ".en.srt"
TRANSLATED_SUFFIX = ".pt.srt"
MAX_WORKERS = 6
LT_URL = "http://localhost:5001/translate"
SLEEP_BETWEEN_REQUESTS = 0.5

# Global flag to handle graceful shutdown
shutdown_requested = False

def signal_handler(sig, frame):
    global shutdown_requested
    print("\nReceived interrupt signal. Shutting down gracefully...")
    shutdown_requested = True
    sys.exit(0)

def strip_tags(text):
    return re.sub(r"<[^>]+>", "", text)

def find_srt_files(root_dir="."):
    srt_files = []
    en_files_found = 0
    en_files_missing_source = 0
    en_files_already_translated = 0
    
    for dirpath, _, filenames in os.walk(root_dir):
        for f in filenames:
            if f.endswith(SOURCE_SUFFIX):
                en_files_found += 1
                full_path = os.path.join(dirpath, f)
                translated_path = full_path.replace(SOURCE_SUFFIX, TRANSLATED_SUFFIX)
                
                if not os.path.exists(full_path):
                    en_files_missing_source += 1
                    print(f"Warning: Source file {full_path} not found (but referenced by {translated_path})")
                elif os.path.exists(translated_path):
                    en_files_already_translated += 1
                    print(f"Skipping {f} (translation already exists)")
                else:
                    srt_files.append(full_path)
    
    # Print summary
    print(f"Scanning complete:")
    print(f"  - Found {en_files_found} files with {SOURCE_SUFFIX} extension")
    if en_files_missing_source > 0:
        print(f"  - {en_files_missing_source} files missing source (.en.srt)")
    if en_files_already_translated > 0:
        print(f"  - {en_files_already_translated} files already translated")
    print(f"  - {len(srt_files)} files queued for translation")
    
    return srt_files

def translate_line(text):
    if shutdown_requested:
        return text
    
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
            },
            timeout=30
        )
        response.raise_for_status()
        return response.json().get("translatedText", "")
    except Exception as e:
        print(f"Error translating line: {text}\n{e}")
        return text

def translate_srt_file(srt_path):
    if shutdown_requested:
        return
    
    if not os.path.exists(srt_path):
        print(f"Error: Source file {srt_path} does not exist. Skipping.")
        return
    
    translated_path = srt_path.replace(SOURCE_SUFFIX, TRANSLATED_SUFFIX)
    
    if os.path.exists(translated_path):
        print(f"Skipping {srt_path} (translation already exists)")
        return

    print(f"Translating {srt_path}")
    
    temp_translated_path = translated_path + ".tmp"
    
    try:
        with open(srt_path, encoding="utf-8") as f:
            lines = f.read().splitlines()

        output_lines = []
        block = []
        for line in lines + [""]:
            if shutdown_requested:
                print(f"Shutdown requested. Aborting translation of {srt_path}")
                return
                
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
                        
                        if shutdown_requested:
                            print(f"Shutdown requested. Aborting translation of {srt_path}")
                            return
                        time.sleep(SLEEP_BETWEEN_REQUESTS)

                    output_lines.append("")
                block = []
            else:
                block.append(line)

        with open(temp_translated_path, "w", encoding="utf-8") as f:
            f.write("\n".join(output_lines))
        
        os.rename(temp_translated_path, translated_path)
        
        print(f"Finished {srt_path}")
        
    except Exception as e:
        if os.path.exists(temp_translated_path):
            os.remove(temp_translated_path)
        print(f"Error processing {srt_path}: {e}")

def main():
    signal.signal(signal.SIGINT, signal_handler)
    
    print("Starting translation process...")
    print(f"Looking for {SOURCE_SUFFIX} files without {TRANSLATED_SUFFIX} counterparts")
    print("-" * 50)
    
    srt_files = find_srt_files()
    print("-" * 50)
    
    if not srt_files:
        # Check if we found any .en.srt files at all
        has_any_en_files = False
        for dirpath, _, filenames in os.walk('.'):
            for f in filenames:
                if f.endswith(SOURCE_SUFFIX):
                    has_any_en_files = True
                    break
            if has_any_en_files:
                break
        
        if has_any_en_files:
            print("No files to translate. All English subtitle files already have Portuguese translations.")
        else:
            print(f"No English subtitle files ({SOURCE_SUFFIX}) found in directory tree.")
        return
        
    print(f"Beginning translation of {len(srt_files)} files...")
    
    try:
        with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
            futures = {executor.submit(translate_srt_file, srt): srt for srt in srt_files}
            for future in as_completed(futures):
                srt = futures[future]
                try:
                    future.result()
                except Exception as e:
                    if not shutdown_requested:
                        print(f"Error processing {srt}: {e}")
    except KeyboardInterrupt:
        print("\nTranslation interrupted by user.")
    finally:
        if shutdown_requested:
            print("Shutdown complete.")

if __name__ == "__main__":
    main()
