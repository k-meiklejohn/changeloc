process RUN_MITOFATES {
    container "mitofates:latest"

    input:
    path input_file
    val organism
    val dir

    output:
    path "mitofates.out"

    script:
    """
    perl /MitoFates/MitoFates.pl $input_file $organism > mitofates.out
    """
}
