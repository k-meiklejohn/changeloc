process RUN_DEEPLOC2 {
    container "deeploc2"

    publishDir "Results"

    input:
    path input_file

    output:
    path "deeploc2.out"

    script:
    """
    deeploc2 -f $input_file -o deeplocdir
    mv deeplocdir/* deeploc2.out
    """
}