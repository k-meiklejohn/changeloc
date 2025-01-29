process RUN_LONG_TABLE {
    container "changeloc/r"
    

    input:
    path prediciton

    output:
    path "*.tsv"

    script:
    """
    long-table.R $prediciton
    """
}