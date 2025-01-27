process RUN_LONG_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/all", mode: "copy"

    input:
    path prediciton
    val dir

    output:
    path "*.tsv"

    script:
    """
    long-table.R $prediciton
    """
}