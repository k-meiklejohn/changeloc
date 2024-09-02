process RUN_AGGREGATE {
    publishDir "Output/${dir}/TSVs/amalg", mode: 'symlink'
    container "changeloc/r"

    input:
    val paths
    val dir

    output:
    path "*.tsv"

    """
    aggregate.R ${paths.join(' ')}
    """
}
