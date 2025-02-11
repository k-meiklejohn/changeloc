#!/bin/bash

# Store the filename from the argument
full_filename="$1"

# Extract the filename without the extension
basename=$(basename "$full_filename" .fasta)
# Use sed to replace everything after " " with the filename without the extension
sed -E "s/(>.*)/\1-changelocset:$basename/" "$full_filename" > "$basename.set.fasta"

cat "$basename.set.fasta"
