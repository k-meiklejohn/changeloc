process RUN_DEEPLOC2 {
    container "deeploc:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    deeploc2 -f $input_file -o output.txt
    """
}