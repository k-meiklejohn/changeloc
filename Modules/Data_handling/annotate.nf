process RUN_ANNOTATE {
    container "changeloc/r"

    input:
    path input

    output:
    path "*.an"

    script:
    """
    annotate.R $input
    """
}