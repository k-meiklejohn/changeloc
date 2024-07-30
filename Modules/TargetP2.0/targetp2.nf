process RUN_TARGETP2 {
    container "targetp2"

    publishDir "Results"

    input:
    path input_file

    output:
    path "*.targetp2"

    script:
    """
    targetp -fasta $input_file
    """
}