process RUN_SIGNALP6 {
    container "signalp6"

    publishDir "Results"

    input:
    path input_file
    val model
    val organism

    output:
    path "signalp6.out"

    script:
    """
    signalp6 --fastafile $input_file --organism $organism --output_dir signalp6  --format none -m $model
    mv signalp6/prediction_results.txt signalp6.out
    """
}
