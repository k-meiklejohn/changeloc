process RUN_MITOFY {
    container "changeloc/r"
    
    input:
    path long_table
    val dir

    output:
    path "*.long"

    script:
    """
    mitofy.R $long_table
    """

}