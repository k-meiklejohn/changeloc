#!/bin/env Rscript

library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

input_file

table <- read_tsv(input_file) %>%
  mutate(annotation = str_extract(seqID, "(?<= ).*"),
         seqID      = str_extract(seqID, "^\\S*"))

write_tsv(table, file = paste0(input_file, ".an"))