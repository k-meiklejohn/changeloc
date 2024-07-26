process RUN_DEEPLOC2 {
    container "deeploc:latest"

    publishDir "Results"

    input:
    path input_file

    output:
    path "deeploc.out"

    script:
    """
    deeploc2 -f $input_file -o deeploc.out
    """
}