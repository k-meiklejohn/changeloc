#!/usr/bin/env Rscript
library(rmarkdown)

args <- commandArgs(trailingOnly = TRUE)

rmd <- args[1]
file <- args[2]
input <- read.delim(file)

render(rmd,
       output_file = paste0(input, ".pdf"),
       params = list(table = input),
       output_dir = getwd())