process RUN_MITOFATES {
    container "mitofates:latest"

    publishDir "Results"

    input:
    path input_file

    output:
    path "mitofates.out"

    script:
    """
    perl /MitoFates/MitoFates.pl $input_file fungi > mitofates.out
    """
}
