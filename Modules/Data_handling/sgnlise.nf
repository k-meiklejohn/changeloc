process RUN_SGNLISE {
    container "changeloc/r"

    input:
    path long_table
    val dir

    output:
    path "*.long"

    script:
    """
    sgnlise.R $long_table
    """

}