#!/bin/bash
# crate a file chapters.txt with:
#################################
# 00:02:12=First chapter
# 00:03:19=Second chapter
#################################

title="${1%%.*}"

input_file="chapters.txt"
output_file="chapters.ffmetadata"

# Create the FFmetadata chapter file
echo ";FFMETADATA1" > "$output_file"

previous_seconds=0

while IFS="=" read -r timestamp chapter_name; do
    # Parse the timestamp and calculate start and end times in seconds
    start_seconds=$(echo "$timestamp" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
    end_seconds=$previous_seconds

    # Update previous_seconds for the next iteration
    previous_seconds=$start_seconds

    echo "[CHAPTER]" >> "$output_file"
    echo "TIMEBASE=1/1000" >> "$output_file"
    echo "START=${end_seconds}000" >> "$output_file"
    echo "END=${start_seconds}000" >> "$output_file"
    echo "title=$chapter_name" >> "$output_file"
done < "$input_file"

echo "Chapter file '$output_file' created successfully."

# Run FFmpeg to add chapters to the video
ffmpeg -i "$1" -i chapters.ffmetadata -map_metadata 1 -metadata title="$title" -c:v copy -c:a copy -y "$title"_edit.mp4
rm -rf $output_file
