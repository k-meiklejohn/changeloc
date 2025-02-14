process RUN_MAP_FASTA {
    publishDir "test"

    input:
    path table
    each map

    output:
    path "*.tsv"

    script:
    """
    map-fasta.sh $table $map
    """

}