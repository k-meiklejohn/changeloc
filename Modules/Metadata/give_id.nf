process RUN_GIVE_ID  {
    input:
    path whole_fasta

    output:
    path"renamed.fasta", emit: fasta
    path"mapping.txt",  emit: map

    script:
    """
    give-id.sh $whole_fasta
    """
}