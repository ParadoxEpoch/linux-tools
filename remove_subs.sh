#!/bin/bash

# Ask for the TV Show name
echo "Please enter the TV Show name:"
read TV_SHOW

# Specify your directory here
DIRECTORY=$1

# Iterate through all MKV and MP4 files in the specified directory
for FILE in "$DIRECTORY"/*.{mkv,mp4}; do
  # Check if file exists (to handle cases where there are no MKV or MP4 files)
  if [ -f "$FILE" ]; then
    # Check if there are forced subtitle tracks 
    FORCED_TRACK=$(ffprobe -v error -select_streams s -show_entries stream=index:disposition=forced -of csv=p=0 "$FILE" | grep ',1')

    # Extract season and episode numbers from the filename
    SEASON_EPISODE=$(basename "$FILE" | grep -oP 'S\d+E\d+')

    # Create output file name
    OUTPUT_FILE="${DIRECTORY}/${TV_SHOW} ${SEASON_EPISODE}.mkv"

    # If forced track exists then use mkvmerge (from the mkvtoolnix suite) to keep only those tracks, else just copy video without any subtitle track.
    if [ -z "$FORCED_TRACK" ]
    then
      mkvmerge -o "$OUTPUT_FILE" -S "$FILE"
    else
      TRACKS_TO_KEEP=$(echo "$FORCED_TRACK" | cut -d',' -f1 | tr '\n' ',' | sed 's/,$//')
      mkvmerge -o "$OUTPUT_FILE" --subtitle-tracks "$TRACKS_TO_KEEP" "$FILE"
    fi
  fi
done