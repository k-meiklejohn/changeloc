process RUN_MITOFATES {
    container "mitofates:latest"

    publishDir "Output/${dir}/Results", mode: "copy"



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
