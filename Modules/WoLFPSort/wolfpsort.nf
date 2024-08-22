process RUN_WOLFPSORT {
    container "wolfpsort"

    publishDir "Results"


    input:
    path input_file

    output:
    path "wolfpsort.out"

    script:
    """
    runWolfPsortSummary fungi < $input_file > wolfpsort.out
    """
}