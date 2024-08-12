include {RUN_SPLIT_FASTA} from "../Modules/Data_handling/split-fasta.nf"
workflow WF_SPLIT_FASTA {
    take: 
    concatenated_fa
    chunk_size

    main:
    // Split the concatenated FASTA file into chunks based on chunk_size
    split_fasta = RUN_SPLIT_FASTA(concatenated_fa, chunk_size)
    

    emit:
    split_fasta              
}