process RUN_AMALGAMATE {
    publishDir "Output/${dir}/TSVs/amalg", mode: 'copy'
    container "changeloc/r"

    input:
    val paths
    val dir

    output:
    path "*.tsv"

    """
    amalgamate.R ${paths.join(' ')}
    """
}
