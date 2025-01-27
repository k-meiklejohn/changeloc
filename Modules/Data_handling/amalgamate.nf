process RUN_AMALGAMATE {
    publishDir "Output/${dir}/TSVs/amalg", mode: 'copy'
    container "changeloc/r"

    input:
    val paths
    val dir

    output:
    path "*.tsv"

    script:
    """
    amalgamate.R ${paths.join(' ')}
    """
}
