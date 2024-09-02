process RUN_WIDE_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/all", mode: "copy"

    input:
    path all_longtable
    val dir

    output:
    path "*.tsv"

    """
    wide-table.R $all_longtable
    """
}