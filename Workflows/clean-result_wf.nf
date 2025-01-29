include { RUN_LONG_TABLE } from '../Modules/Metadata/long-table.nf'
include { RUN_MAP_FASTA } from '../Modules/Metadata/map-fasta.nf'
include { RUN_SET } from '../Modules/Metadata/set.nf'



workflow WF_CLEAN_RESULT {
    take:
    prediction
    run_name
    map

    main:
    mapped = RUN_MAP_FASTA(prediction, map, run_name)
                .view()
    tsv   = RUN_LONG_TABLE(mapped)
                .view()


    emit:
    tsv
}