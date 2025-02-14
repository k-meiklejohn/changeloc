#!/bin/env Rscript
library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

table <- read_tsv(input_file)

# Give set and seqid property to each entry
table <- table %>%
  mutate(set = str_extract(seqID, "(?<=changelocset:)\\w+"))  %>%
  mutate(seqID = str_extract(seqID, ".*(?=-changelocset:)"))

#this gives general non comparative tsv to work with in other reports
write_tsv(table, file = paste0(file_name, ".all.long"))