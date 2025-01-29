process RUN_SET {
    publishDir "Output/${dir}/TSVs/all", mode: "copy"
    container "changeloc/r"

    input:
    path long
    val dir

    output:
    path "*.tsv"

    script:
    """
    set.R $long
    """

}