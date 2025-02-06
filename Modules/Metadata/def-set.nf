process RUN_DEF_SET {
    publishDir "Output/${dir}/Input", mode: "copy"

    input:
    path input_file
    val dir

    output:
    path "*.fasta"
    
    script:
    """
    def-set.sh $input_file
    """
}