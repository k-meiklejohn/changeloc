include { RUN_DEF_SET } from '../Modules/Metadata/def-set.nf'
include { RUN_GIVE_ID } from '../Modules/Metadata/give_id.nf'
include { RUN_SPLIT_FASTA } from '../Modules/Metadata/split-fasta.nf'




workflow WF_PROCESS_FASTA {
take:
fasta
run_name
chunk_size

main:
// gives each entry in file a name based on filename
set_def = RUN_DEF_SET(fasta, run_name)
    .collectFile(name: "Input", newLine: true)

// gives each renamed entry a unique identifier and maps it to original name
id = RUN_GIVE_ID(set_def)
fasta = id.fasta
map = id.map.collect()


// Split the concatenated FASTA file into chunks based on chunk_size
fasta = RUN_SPLIT_FASTA(fasta, chunk_size)
    .flatten()

emit:
fasta
map

}