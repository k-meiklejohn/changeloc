process RUN_MITO_WIDE_TABLE {
    container "changeloc/r"
    publishDir "TSVs/mito"

    input:
    path all_longtable

    output:
    path "*.tsv"

    """
    mito-wide-table.R $all_longtable
    """
}