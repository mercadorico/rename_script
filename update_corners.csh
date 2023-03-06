#!/bin/bash

# Define variables
filelist="filelist.txt"
replacement_file="replacement.txt"

# Count the number of lines in each file
file_count=$(wc -l < "$filelist")
replacement_count=$(wc -l < "$replacement_file")

# Check if the two files have the same number of lines
if [ "$file_count" -ne "$replacement_count" ]; then
  echo "Error: file count does not match replacement count"
  exit 1
fi

# Loop through each file in the filelist
for ((i=1; i<=file_count; i++)); do

    # Get the ith line from the replacement file
    replacement=$(sed -n "${i}p" "$replacement_file")

    # Get the filename from the ith line of the filelist
    filename=$(sed -n "${i}p" "$filelist")

    # Replace the ith line in the file with the replacement string
    sed -i "${i}s/.*/$replacement/" "$filename"

done
