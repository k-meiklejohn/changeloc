#!/bin/env Rscript

library(clusterProfiler)
library(org.Hs.eg.db)
library(tidyverse)

# Load gene list (TSV file)
input_file <- commandArgs(trailingOnly = TRUE)

print(paste("input file is", input_file))

gene_data <- read.table(input_file, header = TRUE, sep = "\t")

filename <- str_extract(input_file, "^.*?(?=\\.)")

changes <- unique(gene_data$consensus_change)

print(paste("unique changes are", changes))

# Separate genes by group
gene_sets <- c()
for (x in changes){
  print(paste("unique change in use", x))
  change_name <- paste0(x, "_genes")
  assign(change_name, gene_data[gene_data$consensus_change == x, "seqID"])
  gene_sets <- append(change_name, gene_sets)

}

print(paste("gene sets:", gene_sets))

# Perform GO enrichment analysis
for (i in gene_sets){
  go_name <- paste0("go_", i)
  assign(go_name,
    enrichGO(
             gene          = get(i),
             OrgDb         = org.Hs.eg.db,
             keyType       = "SYMBOL",
             ont           = "BP",
             pAdjustMethod = "BH",
             pvalueCutoff  = 0.05)
  )
  significant_terms <-
    as.data.frame(get(go_name))[get(go_name)@result$p.adjust < 0.05, ]

  write.csv(get(go_name), file = paste0(filename, "-", go_name, ".csv"))
  write.csv(significant_terms, file = paste0(filename, "-", go_name, "signf.csv"))

}

# Extract significant terms based on adjusted p-value (p.adjust < 0.05)
