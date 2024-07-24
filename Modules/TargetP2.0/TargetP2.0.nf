process RUN_TARGETP {
    container "targetp2"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    targetp -fasta $input_file > output.txt
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_TARGETP(input_ch)
}