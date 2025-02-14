#!/bin/env Rscript

library(tidyverse)
library(seqinr)

input_file <- commandArgs(trailingOnly = TRUE)

proteome <- read.fasta(input_file, seqtype = "AA", whole.header = TRUE)

# Convert list to a data frame
proteome <- tibble(Name = names(proteome),
                   Sequence = I(proteome))


proteome <- proteome %>%
  subset(grepl("GN=", Name) == TRUE) %>%
  mutate(Gene = str_extract(Name, "(?<=GN=)\\S*")) %>%
  mutate(seqID = paste(Gene, str_extract(Name, "^\\S*")))

# Find highest number of repeated genes
max_count <- max(table(proteome$Gene))

# Create empty list to store separate dataframes
df_list <- vector("list", max_count)

# Loop through the number of repeated genes
for (i in 1:max_count) {
  df_list[[i]] <- proteome %>%
    group_by(Gene) %>%
    slice(i) %>%  # Select the i-th occurrence of each category (if it exists)
    ungroup()
}

#write out fasta for each tibble in list.
n <- 1
for (i in df_list) {
  write.fasta(sequences = i$Sequence,
              names = i$Name,
              file.out = paste0(n, ".fasta"))
  n <- n + 1
}
