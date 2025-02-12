process RUN_SPLIT_FASTA {

    input:
    path input_file
    val chunks

    output:
    path "*.fasta"

    script:
    """
    split-fasta.sh $input_file $chunks
    """

}