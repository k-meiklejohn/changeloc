#!/bin/bash

# Check if a filename is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# Store the filename from the argument
full_filename="$1"

# Extract the filename without the extension
basename=$(basename "$full_filename" .fasta)

# Use sed to replace everything after " " with the filename without the extension
sed -E "s/(>\w*)(.*)/\1-changlocset:$basename/" "$full_filename" > out.fasta
