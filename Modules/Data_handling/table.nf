process RUN_TABLE {
    container "rocker/tidyverse"
    publishDir "TSVs"

    input:
    path prediciton

    output:
    path "*.tsv"

    """
    table.R $prediciton
    """
}