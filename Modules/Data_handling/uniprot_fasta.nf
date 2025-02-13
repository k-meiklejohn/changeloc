process RUN_UNIPROT_CONVERT {
    input:
    path proteome

    output:
    path "*.fasta"

    script:
    """
    uniprot_assign.R  $proteome
    """

}