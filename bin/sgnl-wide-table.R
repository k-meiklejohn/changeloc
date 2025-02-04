#!/bin/env Rscript
library(tidyverse)
library(stringr)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

long_table <- read_tsv(input_file)

# List of specific abbreviations to check
abbreviations <- c("sgnl", "golg", "E.R.", "lyso", "plas", "extr", "memb")

pattern <- paste(abbreviations, collapse = "|")

# Modify the 'Prediction' column based on the given conditions
sgnl_table <- long_table %>%
  mutate(Prediction =
      case_when(
        # If Prediction matches any abbreviation directly
        Prediction %in% abbreviations ~ "sgnl",

        # Contains one of the abbreviations (and is not an exact match)
        str_detect(Prediction, pattern) ~ "dual_sgnl",

        # All other cases
        TRUE ~ "othr"
      )
  )

sets <- unique(sgnl_table$set)
columns <- colnames(sgnl_table)
for_pivot <- columns[-c(1)]

# pivots the table to compare Prediction between sets
sgnl_table <- sgnl_table %>%
  pivot_wider(names_from = set, values_from = all_of(for_pivot))

first <- TRUE
for (i in sets){
  if (first == TRUE) {
    sgnl_table <- sgnl_table %>%
      mutate(change = get(paste0("Prediction_", i)))
  }
  if (first == FALSE) {
    sgnl_table <- sgnl_table %>%
      mutate(change =
               paste0(change, "-", get(paste0("Prediction_", i))),
               .after = seqID)
  }
  first <- FALSE

}

write_tsv(sgnl_table, file = paste0(file_name, ".sgnl.wide.tsv"))