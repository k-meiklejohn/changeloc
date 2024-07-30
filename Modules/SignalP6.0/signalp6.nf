process RUN_SIGNALP6 {
    container "signalp6"

    publishDir "Results"

    input:
    path input_file

    output:
    path "signalp6/prediction_results.txt"

    script:
    """
    signalp6 --fastafile $input_file --organism other --output_dir signalp6  --format none
    """
}

workflow{
    input = Channel.fromPath("example.fasta")
    RUN_SIGNALP6(input)
}