process RUN_GO_ANALYSIS {
    container "changeloc/r"
    publishDir "Output/${dir}/GO_analysis", mode: "copy"
    errorStrategy "ignore"

    input:
    path input_file
    val dir

    output:
    path "*.csv"
    
    script:
    """
    go-analysis.R $input_file
    """
}