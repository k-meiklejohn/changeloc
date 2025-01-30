process RUN_WOLFPSORT {
    container "wolfpsort"

    input:
    path input_file
    val organism
    val dir

    output:
    path "wolfpsort.out.unmapped"

    script:
    """
    runWolfPsortSummary $organism < $input_file > wolfpsort.out.unmapped
    """
}