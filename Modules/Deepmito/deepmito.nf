process RUN_DEEPMITO {
    container "deepmito:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_MITOFATES(input_ch)