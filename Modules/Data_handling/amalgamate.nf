process RUN_AMALGAMATE {
    publishDir "Output/${dir}/TSVs/amalg", mode: 'symlink'
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
