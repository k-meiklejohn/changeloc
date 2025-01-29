process RUN_MAP_FASTA {
    publishDir "Output/${dir}/Results", mode: "copy"


    input:
    path table
    path map
    val dir

    output:
    path "*.mapped"

    script:
    """
    map-fasta.sh $table $map
    """

}