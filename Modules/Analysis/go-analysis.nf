process RUN_GO_ANALYSIS {
    container "changeloc/R"
    // publishDir "Output/${dir}/Input", mode: "copy"

    input:
    path input_file
    val dir

    output:
    path
    
    
    script:
    """
    go-analysis.R ${paths.join(' ')}
    """
}