process RUN_MITOFATES {
    container "mitofates:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    perl /MitoFates/MitoFates.pl $input_file fungi > output.txt
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_MITOFATES(input_ch)
}