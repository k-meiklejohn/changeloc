process RUN_MAP_FASTA {
    publishDir "Output/${dir}/Results", mode: "copy"


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