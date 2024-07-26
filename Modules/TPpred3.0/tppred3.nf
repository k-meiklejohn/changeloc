process RUN_TPPRED3 {
    container "tppred3"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    /tppred3/tppred3.py -f $input_file -o output.txt -k N
    """
}