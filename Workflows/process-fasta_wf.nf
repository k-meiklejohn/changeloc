include { RUN_DEF_SET } from '../Modules/Metadata/def-set.nf'
include { RUN_GIVE_ID } from '../Modules/Metadata/give_id.nf'
include { RUN_SPLIT_FASTA } from '../Modules/Metadata/split-fasta.nf'
include { RUN_UNIPROT_CONVERT } from '../Modules/Data_handling/uniprot_fasta.nf'




workflow WF_PROCESS_FASTA {
take:
run_name


main:



if (params.uniprot_fasta == null){
    // Create a channel from the input FASTA files
    fasta = Channel.fromPath(params.fasta)

}
else {
    // if a uniprot proteome fasta is provided, split it into files containing unique genes
    input = Channel.fromPath(params.uniprot_fasta)
    fasta = RUN_UNIPROT_CONVERT(input)

}

// gives each entry in file a name based on filename
set_def = RUN_DEF_SET(fasta, run_name)
    .collectFile(name: "Input", newLine: true)

// gives each renamed entry a unique identifier and maps it to original name
id = RUN_GIVE_ID(set_def)
fasta = id.fasta
map = id.map.collect()


// Split the concatenated FASTA file into chunks based on chunk_size
fasta = RUN_SPLIT_FASTA(fasta, params.chunks, params.pseq)
    .flatten()

emit:
fasta
map

}