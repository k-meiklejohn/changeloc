#!/bin/env Rscript
library(tidyverse)

input_file <- commandArgs(trailingOnly = TRUE)

file_name <- str_extract(input_file, "^.*?(?=\\.)")

if (file_name == "tmhmm2") {
  table <- read_tsv(input_file, col_names = FALSE)
  colnames(table)[5] <- "Prediction"

  table <- table[, c(1, 5)] %>%
    mutate(Prediction = (sub("\\D", "", Prediction)))
  table$Prediction <- as.numeric(as.character(table$Prediction))
  table <- table %>%
    mutate(Prediction = case_when(Prediction != 0 ~ "memb",
                                  TRUE ~ "othr"))
}


if (file_name == "mitofates") {

  #create tempfile
  temp_file <- tempfile()

  # Read the file as lines of text
  lines <- readLines(input_file)

  # Remove trailing tabs from each line
  cleaned_lines <- gsub("\\t$", "", lines)

  # Write the cleaned lines to a new file
  writeLines(cleaned_lines, temp_file)

  # Read the cleaned file with read_tsv
  table <- read_tsv(temp_file, col_names = FALSE)

  unlink(temp_file)

  colnames(table)[3] <- "Prediction"

  # format Predictions
  table <- table[, c(1, 3, 2, 4:21)] %>%
    mutate(Prediction =
             case_when(Prediction == "No mitochondrial presequence"
                       ~ "othr",
                       Prediction == "Possessing mitochondrial presequence"
                       ~ "mito"))

}

if (file_name == "tppred3") {
  table <- read_tsv(input_file, col_names = FALSE)
  table$X2 <- NULL

  # format Predictions
  colnames(table)[2] <- "Prediction"
  table <- table %>%
    distinct(X1, .keep_all = TRUE) %>%
    mutate(Prediction = case_when(Prediction == "Chain" ~ "othr",
                                  Prediction == "Transit peptide" ~ "mito"))
}

if (file_name == "wolfpsort") {
  temp_file <- tempfile()

  file_content <- readLines(input_file)

  # Remove all commas from each line
  file_content <- gsub(",", "", file_content)

  # Write the modified content to the temporary file
  writeLines(file_content, temp_file)

  # Initialize the max column count
  largest_column_count <- 0

  # Loop through each line in the file
  lines <- readLines(temp_file)

  for (line in lines) {
    # Count the number of columns in the current line
    column_count <- length(strsplit(line, " ")[[1]])

    # Update the largest column count if the current line has more columns
    if (column_count > largest_column_count) {
      largest_column_count <- column_count
    }
  }

  # Generate column names (will be 1, 2, 3, ..., largest_column_count)
  column_names <- seq(1, largest_column_count)

  # Read the CSV into a data frame
  table <- read_delim(temp_file, col_names = column_names, delim = " ")

  unlink(temp_file)

}

if (file_name == "targetp2") {
  table <- read_tsv(input_file)

  colnames(table)[2] <- "Prediction"
  table <- table %>%
    mutate(Prediction = case_when(Prediction == "noTP" ~ "othr",
                                  Prediction == "mTP" ~ "mito",
                                  Prediction == "SP" ~ "sgnl"))
}

if (file_name == "signalp6") {
  table <- read_tsv(input_file)

  colnames(table)[2] <- "Prediction"
  table <- table %>%
    mutate(Prediction = case_when(Prediction == "OTHER" ~ "othr",
                                  Prediction == "SP" ~ "sgnl"))
}

if (file_name == "deeploc2") {
  table <- read_csv(input_file)

  colnames(table)[2] <- "Prediction"


  abbreviations <- c(
                     "Nucleus" = "nucl",
                     "Cytoplasm" = "cyto",
                     "Extracellular" = "extr",
                     "Mitochondrion" = "mito",
                     "Cell membrane" = "plas",
                     "Endoplasmic reticulum" = "E.R.",
                     "Chloroplast" = "chlr",
                     "Golgi apparatus" = "golg",
                     "Lysosome/Vacuole" = "lyso",
                     "Peroxisome" = "pero")

  #function to map Predictions to abbreviations
  map_abbrev <- function(pred, abbreviations) {
    sapply(pred, function(prediction) {
      if (grepl("\\|", prediction)) {
        components <- strsplit(pred, "\\|")[[1]]
        abbrev_components <- abbreviations[components]
        paste(sort(abbrev_components), collapse = "_")
      } else {
        abbreviations[prediction]
      }
    })
  }

  #use above function to change abbreviations to correct format
  table <- table %>%
    mutate(Prediction = map_abbrev(Prediction, abbreviations))
}


#remanes first column to seqID and makes a list of columns to use to create data
colnames(table)[1] <- "seqID"
colnames(table)[2] <- "Prediction"

#this gives general non comparative tsv to work with in other reports
write_tsv(table, file = paste0(file_name, ".unmapped.long.tsv"))
