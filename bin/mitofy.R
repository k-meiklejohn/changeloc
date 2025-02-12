#!/bin/env Rscript
library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

long_table <- read_tsv(input_file)

mito_table <- long_table %>%
  mutate(Prediction =
      case_when(
        grepl("mito", Prediction) ~ "mito",
        TRUE ~ "othr"
      )
  )

write_tsv(mito_table, file = paste0(file_name, ".mito.long"))