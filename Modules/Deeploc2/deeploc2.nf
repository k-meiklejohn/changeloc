process RUN_DEEPLOC {
    container "deeploc:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    deeploc2 -f $input_file -o output.txt
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_DEEPLOC(input_ch)
}