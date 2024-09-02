process RUN_DEF_SET {
    publishDir "Output/${dir}/Input"

    input:
    path input_file
    val dir

    output:
    path "*.fasta"
    

    """
    def-set.sh $input_file
    """
}