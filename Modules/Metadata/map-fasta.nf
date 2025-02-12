process RUN_MAP_FASTA {

    input:
    path table
    each map
    val dir

    output:
    path "*.tsv"

    script:
    """
    map-fasta.sh $table $map
    """

}