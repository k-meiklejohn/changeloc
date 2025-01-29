#!/bin/env Rscript
library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

table <- read_tsv(input_file)

