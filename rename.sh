#!/bin/bash

OLD_FILENAMES="old_filenames.txt"
NEW_FILENAMES="new_filenames.txt"

# Check if the text files exist
if [[ ! -f "$OLD_FILENAMES" ]] || [[ ! -f "$NEW_FILENAMES" ]]; then
  echo "Error: File names text files do not exist."
  exit 1
fi

# Read the old and new file names from the text files
OLD_NAMES=$(cat "$OLD_FILENAMES")
NEW_NAMES=$(cat "$NEW_FILENAMES")

# Split the file names into an array
IFS=$'\n' read -d '' -r -a OLD_ARRAY <<< "$OLD_NAMES"
IFS=$'\n' read -d '' -r -a NEW_ARRAY <<< "$NEW_NAMES"

# Check if the number of old and new file names match
if [[ ${#OLD_ARRAY[@]} -ne ${#NEW_ARRAY[@]} ]]; then
  echo "Error: Number of old and new file names do not match."
  exit 1
fi

# Loop through the old file names and rename the files
for i in "${!OLD_ARRAY[@]}"; do
  OLD_NAME="${OLD_ARRAY[$i]}"
  NEW_NAME="${NEW_ARRAY[$i]}"
  
  # Check if the old file exists
  if [[ ! -f "$OLD_NAME" ]]; then
    echo "Error: File $OLD_NAME does not exist."
    exit 1
  fi
  
  # Rename the file
  mv "$OLD_NAME" "$NEW_NAME"
  
  echo "File $OLD_NAME renamed to $NEW_NAME."
done
