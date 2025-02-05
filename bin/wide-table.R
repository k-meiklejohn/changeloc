#!/bin/env Rscript

library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

long_table <- read_tsv(input_file)

sets <- unique(long_table$set)
columns <- colnames(long_table)
for_pivot <- columns[-c(1)]

# pivots the table to compare Prediction between sets
wide_table <- long_table %>%
  pivot_wider(names_from = set, values_from = all_of(for_pivot))

first <- TRUE
for (i in sets){
  if (first == TRUE) {
    wide_table <- wide_table %>%
      mutate(change = get(paste0("Prediction_", i)))
  }
  if (first == FALSE) {
    wide_table <- wide_table %>%
      mutate(change = paste0(change, "-", get(paste0("Prediction_", i))), .after = seqID)
  }
  first <- FALSE

}

write_tsv(wide_table, file = paste0(file_name, ".all.wide.tsv"))