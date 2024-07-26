process RUN_MITOFATES {
    container "elm:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    python /elm.py $input_file > output.txt
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_MITOFATES(input_ch)
}