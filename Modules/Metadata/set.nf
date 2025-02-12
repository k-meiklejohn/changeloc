process RUN_SET {
    publishDir "Output/${dir}/Results", mode: "copy"
    container "changeloc/r"

    input:
    path table
    val dir

    output:
    path "*.long"

    script:
    """
    set.R $table
    """

}