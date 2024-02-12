#!/bin/bash


# Set the source language and target language
source_lang="en"
target_lang="pt-BR"  # Change this to your target language

# Naming pattern for translated files
translated_pattern="pt-BR.srt"

# Directory containing the .srt files
directory="${1%/}"

# Function to translate an SRT file
translate_srt() {
    file="$1"
	echo "Translating ${srt_file}"
    trans -b "$source_lang:$target_lang" -i "$file" -o "${file%.srt}.pt-BR.srt" > /dev/null
	echo "Translated ${srt_file}"
}

# Process each .srt file in parallel
for srt_file in "$directory"/*.srt; do
	    if [[ $srt_file != *"$translated_pattern" ]]; then
    		translate_srt "$srt_file" &
	    fi
done

# Wait for all translation processes to finish
wait

echo "Translation completed."

