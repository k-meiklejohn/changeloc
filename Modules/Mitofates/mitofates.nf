process RUN_MITOFATES {
    container "mitofates:latest"

    publishDir "Results"



    input:
    path input_file
    val organism

    output:
    path "mitofates.out"

    script:
    """
    perl /MitoFates/MitoFates.pl $input_file $organism > mitofates.out
    """
}
