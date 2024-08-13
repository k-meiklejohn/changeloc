process RUN_WIDE_TABLE {
    container "changeloc/r"
    publishDir "TSVs/all"

    input:
    path all_longtable

    output:
    path "*.tsv"

    """
    wide-table.R $all_longtable
    """
}