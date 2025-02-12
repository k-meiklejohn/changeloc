#!/bin/env Rscript
library(tidyverse)

# Capture the file paths from command-line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) <= 1) {
  quit()
}

file_paths <- as.character(args)

file_name <- str_extract(file_paths[1], "(?<=\\.)[^.]+(?=\\.)")

#Read each TSV file into a list of data frames
list_of_dfs <- map(file_paths, read_tsv)

# Optionally, name the list with the file names
names(list_of_dfs) <- basename(file_paths)

list_of_dfs <- map(list_of_dfs, ~ .x %>%
                     select(seqID, change))

merged_df <- reduce(list_of_dfs, full_join, by = "seqID")


merged_df <- merged_df %>%
  rowwise() %>%
  mutate(
    consensus_change = {
      mode_value <- names(which.max(table(c_across(starts_with("change")))))
    },
    consensus_count =
      sum(c_across(starts_with("change")) == consensus_change, na.rm = TRUE)
  ) %>%
  ungroup()

merged_df <- merged_df %>%
  select(seqID, consensus_change, consensus_count) %>%
  arrange(desc(consensus_count))

df_list <- c()
n <- 1
for (i in unique(merged_df$consensus_change)) {
  df_list[[n]] <- subset(merged_df, consensus_change == i)
  n <- n + 1
}

write_tsv(merged_df, file = paste0(file_name, ".amalg.tsv"))

for (i in df_list){
  write_tsv(i[c(1, 3)],
            file = paste0(file_name, "_", i$consensus_change[1], ".amalg.tsv"))

}
