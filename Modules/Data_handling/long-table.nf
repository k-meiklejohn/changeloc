process RUN_LONG_TABLE {
    container "changeloc/r"
    publishDir "TSVs/all"

    input:
    path prediciton

    output:
    path "*.tsv"

    """
    long-table.R $prediciton
    """
}