process RUN_TARGETP2 {
    container "targetp2"

    publishDir "Results"
    

    input:
    path input_file
    val organism

    output:
    path "targetp2.out"

    script:
    """
    targetp -fasta $input_file -org $organism
    mv *.targetp2 targetp2.out
    """
}