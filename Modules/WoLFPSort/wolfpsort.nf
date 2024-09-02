process RUN_WOLFPSORT {
    container "wolfpsort"

    publishDir "Output/${dir}/Results"


    input:
    path input_file
    val organism
    val dir

    output:
    path "wolfpsort.out"

    script:
    """
    runWolfPsortSummary $organism < $input_file > wolfpsort.out
    """
}