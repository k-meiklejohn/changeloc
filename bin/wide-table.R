#!/bin/env Rscript

library(tidyverse)

# Get input file
input_file <- commandArgs(trailingOnly = TRUE)[1]

# Extract base file name without extension
file_name <- str_extract(input_file, "^\\w*\\.\\w*")

# Read input file as a tibble
long_table <- read_tsv(input_file)

# Extract unique sets and column names
sets <- unique(long_table$set)
columns <- colnames(long_table)
for_pivot <- columns[-1]  # Exclude first column from pivoting

# Pivot the table to compare "Prediction" across sets
wide_table <- long_table %>%
  pivot_wider(names_from = set,
              values_from = all_of(for_pivot),
              values_fill = NA)

# Initialize `change` column by comparing predictions across sets
wide_table <- wide_table %>%
  rowwise() %>%
  mutate(
    change = str_c(
      sort(na.omit(c_across(starts_with("Prediction_")))),
      collapse = "-"
    )
  ) %>%
  ungroup()

# Write output to a new TSV file
write_tsv(wide_table, file = paste0(file_name, ".wide"))