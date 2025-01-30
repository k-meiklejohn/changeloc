process RUN_SIGNALP6 {
    container "signalp6"

    input:
    path input_file
    val model
    val organism
    val dir

    output:
    path "signalp6.out.unmapped"

    script:
    """
    signalp6 --fastafile $input_file --organism $organism --output_dir signalp6  --format none -m $model
    mv signalp6/prediction_results.txt signalp6.out.unmapped
    """
}
