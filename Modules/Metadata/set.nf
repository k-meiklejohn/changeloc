process RUN_SET {
    publishDir "Output/${dir}/TSVs/all", mode: "copy"
    container "changeloc/r"

    input:
    path table
    val dir

    output:
    path "*.tsv"

    script:
    """
    set.R $table
    """

}