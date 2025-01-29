process RUN_DEEPLOC2 {
    container "deeploc2"


    input:
    path input_file
    val model
    val dir

    output:
    path "deeploc2.out"

    script:
    """
    deeploc2 -f $input_file -o deeplocdir -m $model
    mv deeplocdir/* deeploc2.out
    """
}