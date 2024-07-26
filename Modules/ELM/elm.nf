process RUN_ELM {
    container "elm:latest"

    input:
    path input_file

    output:
    path "output.txt"

    script:
    """
    python /elm.py $input_file > output.txt
    """
}