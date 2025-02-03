process RUN_SGNL_WIDE_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/sgnl", mode: "copy"

    input:
    path all_longtable
    val dir

    output:
    path "*.tsv"

    script:
    """
    sgnl-wide-table.R $all_longtable
    """
}