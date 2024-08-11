input_file <- commandArgs(trailingOnly = TRUE)


if (input_file == "mitofates.out") {
  table <- read.delim(input_file, row.names = NULL)
}

if (input_file == "tppred3.out") {
  table <- read.delim(input_file, row.names = NULL, header = FALSE)
}

if (input_file == "wolfpsort.out") {
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
  table <- read.delim(temp_file,
                      header = FALSE,
                      col.names = column_names,
                      row.names = NULL,
                      sep = " ")

  unlink(temp_file)

}

if (input_file == "targetp2.out") {
  table <- read.delim(input_file)
}

if (input_file == "signalp6.out") {
  table <- read.delim(input_file)
}

if (input_file == "deeploc2.out") {
  table <- read.csv(input_file)
}

colnames(table)[1] <- "seqID"
colnames(table)[2] <- "Prediction"
columns <- colnames(table)
forPivot <- columns[-c(1)]

table <- table %>%
    mutate(set = str_extract(str_extract(seqID, "changelocset:\\d+"), "\\d+" )) %>%
    mutate(seqID = str_extract(seqID, "^.*(?=(-changelocset))")) %>%
    pivot_wider(names_from = set, values_from = all_of(forPivot) )

table <- table %>%
  mutate(change =)

write_tsv(table, file = paste0(input_file, ".tsv"))

