process RUN_DEEPMITO {
    container "deepmito"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    deepmito.py
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_DEEPMITO(input_ch)
}