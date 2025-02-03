process RUN_TPPRED3 {
    container "tppred3"

    input:
    path input_file
    val organism
    val dir

    output:
    path "tppred3.out.unmapped"

    script:
    """
    /tppred3/tppred3.py -f $input_file -o tppred3.out.unmapped -k $organism
    """
}