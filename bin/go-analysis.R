library(clusterProfiler)
library(org.Hs.eg.db)

# Load gene list (TSV file)
gene_data <- read.table("sgnl.amalg.tsv", header = TRUE, sep = "\t")

# Separate genes by group
group1_genes <- gene_data[gene_data$consensus_change == "othr-sgnl", "seqID"]
group2_genes <- gene_data[gene_data$consensus_change != "othr-sgnl", "seqID"]

# Perform GO enrichment analysis
go_results <- enrichGO(gene          = group1_genes,
                       OrgDb         = org.Hs.eg.db,
                       keyType       = "SYMBOL",
                       ont           = "BP",
                       pAdjustMethod = "BH",
                       pvalueCutoff  = 0.05)

# View results
head(summary(go_results))

# Extract significant terms based on adjusted p-value (p.adjust < 0.05)
significant_terms <- as.data.frame(go_results)[go_results@result$p.adjust < 0.05, ]
print(significant_terms)