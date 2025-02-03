#!/bin/bash

input_txt="$1"
mapping_file="$2"
output_txt="${input_txt/unmapped/"mapped"}"

declare -A id_map
while read -r original_id unique_id; do
    id_map["$unique_id"]="$original_id"
done < <(tail -n +2 "$mapping_file")

while read -r line; do
    for id in $(printf "%s\n" "${!id_map[@]}" | sort -rV); do
        if [[ "$line" =~ ^$id ]]; then
            echo "${id_map[$id]}${line#$id}"
            unset id_map["$id"]
            continue 2
        fi
    done
    echo "$line"
done < "$input_txt" > "$output_txt"
