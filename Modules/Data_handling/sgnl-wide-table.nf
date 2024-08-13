process RUN_SGNL_WIDE_TABLE {
    container "changeloc/r"
    publishDir "TSVs/sgnl"

    input:
    path all_longtable

    output:
    path "*.tsv"

    """
    sgnl-wide-table.R $all_longtable
    """
}