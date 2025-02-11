include { RUN_LONG_TABLE } from '../Modules/Metadata/long-table.nf'
include { RUN_MAP_FASTA } from '../Modules/Metadata/map-fasta.nf'
include { RUN_SET } from '../Modules/Metadata/set.nf'
include { RUN_MITOFY } from '../Modules/Data_handling/mitofy.nf'
include { RUN_SGNLISE } from '../Modules/Data_handling/sgnlise.nf'



workflow WF_CLEAN_RESULT {
    take:
    prediction
    run_name
    map

    main:
    cleaned = RUN_LONG_TABLE(prediction)

    mapped  = RUN_MAP_FASTA(cleaned, map, run_name)

    // clean until here

    all     = RUN_SET(mapped, run_name).view()

    mito    = RUN_MITOFY(all, run_name)

    sgnl    = RUN_SGNLISE(all, run_name)

    full = all.mix(mito, sgnl)

    emit:
    full
}