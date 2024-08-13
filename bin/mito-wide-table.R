#!/bin/env Rscript
library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)" )

long_table <- read_tsv(input_file)

mito_table <- long_table %>%
  mutate(Prediction =
      case_when(
        grepl("mito_|_mito", Prediction) ~ "dual_mito",
        grepl("mito", Prediction) ~ "mito",
        TRUE ~ "othr"
      )
  )

sets <- unique(mito_table$set)
columns <- colnames(mito_table)
for_pivot <- columns[-c(1)]

# pivots the table to compare Prediction between sets
mito_table <- mito_table %>%
  pivot_wider(names_from = set, values_from = all_of(for_pivot))

first <- TRUE
for (i in sets){
  if (first == TRUE) {
    mito_table <- mito_table %>%
      mutate(change = get(paste0("Prediction_", i)))
  }
  if (first == FALSE) {
    mito_table <- mito_table %>%
      mutate(change = paste0(change, "-", get(paste0("Prediction_", i))), .after = seqID)
  }
  first <- FALSE

}

write_tsv(mito_table, file = paste0(file_name, ".mito.wide.tsv"))