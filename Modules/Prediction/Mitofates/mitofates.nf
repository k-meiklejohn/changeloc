process RUN_MITOFATES {
    container "mitofates:latest"

    input:
    path input_file
    val organism
    val dir

    output:
    path "mitofates.out.unmapped"

    script:
    """
    perl /MitoFates/MitoFates.pl $input_file $organism > mitofates.out.unmapped
    """
}
