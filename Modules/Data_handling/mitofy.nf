process RUN_MITOFY {
    container "changeloc/r"
    publishDir "Output/${dir}/TSVs/mito", mode: "copy"
    
    input:
    path long_table
    val dir

    output:
    path "*.tsv"

    script:
    """
    mitofy.R $long_table
    """

}