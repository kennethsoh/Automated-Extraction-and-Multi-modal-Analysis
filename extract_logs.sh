#!/bin/bash

# Define the output file
output_file="system_logs.txt"

# Clear the output file if it already exists
> "$output_file"

uncompress() {
  input=$1
  if [[ $(file -b "$input") == *"XZ compressed"* ]]; then
    xz -d $input -c > ${input}.txt
    echo "${input}.txt"
  elif [[ $(file -b "$input") == *"Journal"* ]]; then
    journalctl --file ${input} > ${input}.txt 
    echo "${input}.txt"
  else
    echo $1
  fi
}

# Function to extract logs from a directory
extract_logs() {
  local dir=$1
  local file

  for filename in "$dir"/*; do
    if [[ -f $filename ]]; then
      file=$(uncompress $filename)
      echo "===== Start of $file =====" >> "$output_file"
      cat "$file" >> "$output_file"
      echo "===== End of $file =====" >> "$output_file"
      echo -e "\n\n" >> "$output_file"
    elif [[ -d $filename ]]; then
      extract_logs "$filename"
    fi
  done
}

# Extract logs from /var/log directory
extract_logs "/var/log"

echo "Logs have been extracted to $output_file."
