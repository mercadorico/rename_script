#!/bin/bash

# Set the input file path and line number
INPUT_FILE="list_of_files.txt"
echo "Please provide string pattern to identify line to replace:"
read input_string

if [ $input_string == "BATCH_SIM_DIR" ]
then
  dir="/user/server01/foundry/tech_node/folder/ip_ckt/simulations/ip/technology-code/release_ver/design/sim_data/tb_block_name/"
else
  dir=""
fi

# Loop through each file listed in the input file
for FILENAME in $(cat "$INPUT_FILE"); do
  # Check if the file exists
  if [[ ! -f "$FILENAME" ]]; then
    echo "Error: File $FILENAME does not exist."
    continue
  fi
  
  #Identify line number of input string
  LINE_NUMBER=$(grep -n -F -w "$input_string" FILENAME | cut -d : -f 1)

  # Count the whitespace characters
  count_space=$(expr "$input_string" : '^[^[:space:]]*[[:space:]]*\(.*\)') 
  
  # Get the new line from the filename
  NEW_LINE=$(basename "$FILENAME" | cut -d '.' -f 1)
  
  # Replace the line
  sed -i "${LINE_NUMBER}s/.*/$("${input_string}${count_space}${dir}${NEW_LINE}")/" "$FILENAME"
  
  echo "Replaced line in $FILENAME."
done
