//working

process RUN_WOLFPSORT {
    container "wolfpsort"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    runWolfPsortSummary fungi < $input_file
    """
}

workflow {
    input_ch = channel.fromPath("example.fasta")

    RUN_WOLFPSORT(input_ch)
}