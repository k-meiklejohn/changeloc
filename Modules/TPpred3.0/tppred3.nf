process RUN_TPPRED3 {
    container "tppred3"

    publishDir "Results"

    input:
    path input_file

    output:
    path "tppred3.out"

    script:
    """
    /tppred3/tppred3.py -f $input_file -o tppred3.out -k N
    """
}