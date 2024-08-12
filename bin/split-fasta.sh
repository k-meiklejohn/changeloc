#!/bin/bash
input_file="$1"
num_chunks="$2"

# Count the total number of sequences
total_sequences=$(grep -c '^>' "$input_file")

# Calculate the number of sequences per chunk
seqs_per_chunk=$(( (total_sequences + num_chunks - 1) / num_chunks ))

# Split the file
awk -v n="$seqs_per_chunk"  '
BEGIN { chunk=1; seq_count=0 }
{
    if (/^>/) {
        if (seq_count == n) {
            chunk++;
            seq_count = 0;
        }
        if (seq_count == 0) {
            close(out_file);
            out_file =  chunk ".fasta";
        }
        seq_count++;
    }
    print >> out_file;
}' "$input_file"
