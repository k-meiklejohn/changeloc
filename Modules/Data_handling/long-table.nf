process RUN_LONG_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/all"

    input:
    path prediciton
    val dir

    output:
    path "*.tsv"

    """
    long-table.R $prediciton
    """
}