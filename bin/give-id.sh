#!/bin/bash

input_fasta="$1"
output_fasta="renamed.fasta"
mapping_file="mapping.txt"

echo -e "# Original_Name\tUnique_ID" > "$mapping_file"

count=1
while read -r line; do
    if [[ "$line" =~ ^\> ]]; then
        original_name=${line#>}
        unique_id="seq_${count}"
        echo ">$unique_id" >> "$output_fasta"
        echo -e "$original_name\t$unique_id" >> "$mapping_file"       
        ((count++))
    else
        echo "$line" >> "$output_fasta"
    fi
done < "$input_fasta"
