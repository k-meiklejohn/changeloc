process RUN_WOLFPSORT {
    container "wolfpsort"

    publishDir "Results"


    input:
    path input_file
    val organism

    output:
    path "wolfpsort.out"

    script:
    """
    runWolfPsortSummary $organism < $input_file > wolfpsort.out
    """
}