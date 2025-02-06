process RUN_SGNLISE {
        container "changeloc/r"
    publishDir "Output/${dir}/TSVs/sngl", mode: "copy"

    input:
    path long_table
    val dir

    output:
    path "*.tsv"

    script:
    """
    sgnlise.R $long_table
    """

}