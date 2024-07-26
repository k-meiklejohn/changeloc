process RUN_TARGETP2 {
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