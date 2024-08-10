process RUN_TABLE {
    publishDir "CSVs"

    input:
    path prediciton

    output:
    path "*.csv"

    """
    Rscript ../../../Scripts/RScripts/table.R $prediciton
    """
}