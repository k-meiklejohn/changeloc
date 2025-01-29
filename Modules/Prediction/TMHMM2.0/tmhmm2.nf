process RUN_TMHMM2 {
    container "tmhmm2"

    input:
    path input_file
    val dir
 
    output:
    path "tmhmm2.out"

    script:
    """
    tmhmm -short $input_file > tmhmm2.out
    """
}
