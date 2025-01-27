process RUN_MITO_WIDE_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/mito", mode: "copy"

    input:
    path all_longtable
    val dir

    output:
    path "*.tsv"

    script:
    """
    mito-wide-table.R $all_longtable
    """
}