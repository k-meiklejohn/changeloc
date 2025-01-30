include { RUN_LONG_TABLE } from '../Modules/Metadata/long-table.nf'
include { RUN_MAP_FASTA } from '../Modules/Metadata/map-fasta.nf'
include { RUN_SET } from '../Modules/Metadata/set.nf'



workflow WF_CLEAN_RESULT {
    take:
    prediction
    run_name
    map

    main:
    cleaned = RUN_LONG_TABLE(prediction)

    mapped  = RUN_MAP_FASTA(cleaned, map, run_name)

    set     = RUN_SET(mapped, run_name)

    emit:
    set
}