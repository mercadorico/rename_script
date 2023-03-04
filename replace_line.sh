#!/bin/bash

# Set the TESTBENCH and BATCH_SIM_DIR similar to bbSIm config name.
INPUT_FILE="list_of_files"

# Check if the file exists
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: File $INPUT_FILE does not exist."
  exit 1
fi

echo "Please input BSD for BATCH_SIM_DIR or TB for TESTBENCH"
read input_string

if [ $input_string == "BSD" ]
then
  text_form="BATCH_SIM_DIR"
  dir="/remote/us01sgnfs00587/intel/intel18a/ifs/gpio_18_12/sims_bbsim/gpio/f533-gpio-int18a-1.2v/rel1.00/design/batch_sim/dwc_gpio18_bd_sch/"
elif [ $input_string == "TB" ]
then
  text_form="TESTBENCH"
  dir=""
else
  echo "Error: Invalid Input."
  exit 1
fi

# Loop through each file listed in the input file
for FILENAME in $(cat "$INPUT_FILE"); do
  # Check if the file exists
  if [[ ! -f "$FILENAME" ]]; then
    echo "Error: File $FILENAME does not exist."
    continue
  fi
  
  #Identify line number of input string
  LINE_NUMBER=$(grep -n -F -w "$text_form" $FILENAME | cut -d : -f 1)


  # Get the new line from the filename
  NEW_LINE=$(basename "$FILENAME" | cut -d '.' -f 1)
  
  # Replace the line
  sed -i "$(echo $LINE_NUMBER)s:.*:$(echo "${text_form}\t\t${dir}${NEW_LINE}"):" $FILENAME

  echo "Replaced line in $text_form $FILENAME."

done
