process RUN_TABLE {
    // publishDir "CSVs"

    input:
    path csvs

    output:
    path "*.csv"

    """
    Rscript ../../../Scripts/RScripts/table.R $prediciton
    """
}