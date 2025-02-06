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

        # Contains one of the abbreviations (and is not an exact match)
        str_detect(Prediction, pattern) ~ "sgnl",

        # All other cases
        TRUE ~ "othr"
      )
  )

write_tsv(sgnl_table, file = paste0(file_name, ".sgnl.long.tsv"))