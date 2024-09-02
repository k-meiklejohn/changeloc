process RUN_AGGREGATE {
    publishDir "Output/${dir}/TSVs/amalg", mode: 'copy'
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
