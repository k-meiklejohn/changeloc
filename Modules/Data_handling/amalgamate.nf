process RUN_AMALGAMATE {
    publishDir "TSVs/amalg", mode: 'symlink'
    container "changeloc/r"

    input:
    val paths

    output:
    path "*.tsv"

    """
    amalgamate.R ${paths.join(' ')}
    """
}
