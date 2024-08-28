#!/bin/env Rscript
library(tidyverse)

# Capture the file paths from command-line arguments
args <- commandArgs(trailingOnly = TRUE)

file_paths <- as.character(args)

file_paths

#Read each TSV file into a list of data frames
list_of_dfs  <- lapply(file_paths, function(file) {
  # Extract file name without extension
  file_name <- tools::file_path_sans_ext(basename(file))

  # Read the file with original column names
  df <- read_tsv(file)

  # Combine file name and original column names
   colnames(df) <- ifelse(colnames(df) == "seqID",
                          "seqID",
                          paste(file_name, colnames(df), sep = "_"))
  return(df)
})


merged_df <- reduce(list_of_dfs, full_join, by = "seqID")

write_tsv(merged_df, file = "full.amalg.tsv")