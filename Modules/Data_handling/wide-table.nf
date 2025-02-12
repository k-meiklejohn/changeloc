process RUN_WIDE_TABLE {
    container "changeloc/r"
    publishDir "Output/${dir}/Wide", mode: "copy"

    input:
    path all_longtable
    val dir

    output:
    path "*.wide"

    script:
    """
    wide-table.R $all_longtable
    """
}