process RUN_DEF_SET {

publishDir "test"
    input:
    path input_file

    output:
    path "*.fasta"

    """
    def-set.sh $input_file
    """
}