process RUN_AGGREGATE {
    publishDir "TSVs/amalg", mode: 'symlink'
    container "changeloc/r"

    input:
    val paths

    output:
    path "*.tsv"

    """
    aggregate.R ${paths.join(' ')}
    """
}
