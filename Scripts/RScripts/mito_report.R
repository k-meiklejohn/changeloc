library(tidyverse)

mito_table <- read_tsv(input_file)

mito_table <- mito-table %>%
    mutate(mito_change = case_when(grepl("_", change) ~ case_when(
    )))