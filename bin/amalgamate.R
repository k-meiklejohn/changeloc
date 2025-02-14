#!/bin/env Rscript
library(tidyverse)

# Capture the file paths from command-line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) <= 1) {
  quit()
}

file_paths <- as.character((args[-length(args)]))

# get the consensus threshold from the argument
consensus_threshold <- as.numeric(args[length(args)])

file_name <- str_extract(file_paths[1], "(?<=\\.)[^.]+(?=\\.)")

#Read each TSV file into a list of data frames
list_of_dfs <- map(file_paths, read_tsv)

# Optionally, name the list with the file names
names(list_of_dfs) <- basename(file_paths)

# join the give tsvs into one
list_of_dfs <- map(list_of_dfs, ~ .x %>%
                     select(seqID, change, starts_with("annotation")))

merged_df <- reduce(list_of_dfs, full_join, by = "seqID")

# remove the duplicated annotation columns
merged_df <- merged_df[, !duplicated(as.list(merged_df))]


# calculate consesnsus change and consesnsus count
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


# make df neater and sort by consensus
merged_df <- merged_df %>%
  select(seqID,
         consensus_change,
         consensus_count,
         starts_with("annotation")) %>%
  arrange(desc(consensus_count))


# clip any values below threshold
merged_df_threshold <- merged_df %>%
  subset(consensus_count >= consensus_threshold)

# make a list of dfs for each unique change
df_list <- c()
n <- 1
for (i in unique(merged_df_threshold$consensus_change)) {
  df_list[[n]] <- subset(merged_df, consensus_change == i)
  n <- n + 1
}


# print the raw and unclipped versions
if (consensus_threshold >= 1) {
  write_tsv(merged_df, file = paste0(file_name, ".raw.amalg.tsv"))
  write_tsv(merged_df_threshold, file = paste0(file_name, ".clipped.amalg.tsv"))
} else {
  "point3"
  write_tsv(merged_df_threshold,
            file = paste0(file_name, ".clipped.amalg.tsv"))

}


# print the grouped data frames
for (i in df_list){
  write_tsv(i[c(1, 3)],
            file = paste0(file_name,
                          "_",
                          i$consensus_change[1],
                          ".amalg.tsv"))
}
