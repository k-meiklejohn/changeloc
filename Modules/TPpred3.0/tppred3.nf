process RUN_TPPRED3 {
    container "tppredtest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    tppred3.py -f $input_file -o output.txt -k N
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_TPPRED3(input_ch)
}