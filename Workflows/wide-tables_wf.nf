include { RUN_WIDE_TABLE } from '../Modules/Data_handling/wide-table.nf'
include { RUN_MITO_WIDE_TABLE } from '../Modules/Data_handling/mito-wide-table.nf'
include { RUN_SGNL_WIDE_TABLE } from '../Modules/Data_handling/sgnl-wide-table.nf'
include { RUN_AMALGAMATE } from '../Modules/Data_handling/amalgamate.nf'
include { RUN_AGGREGATE } from '../Modules/Data_handling/aggregate.nf'
include { RUN_AUTO_REPORT } from '../Modules/Report/auto-report.nf'



workflow WF_WIDE_TABLES{
    take:
    prediction
    run_name

    main:
    
    keep_mito = [
        "mitofates",
        "tppred3",
        "deeploc2",
        "targetp2",
        "wolfpsort",
        "targetp2"]
    

    keep_sgnl = [
        "signalp6",
        "targetp2",
        "wolfpsort",
        "deeploc2",
        "tmhmm2"]
    
    

    all = RUN_WIDE_TABLE(prediction, run_name)

    mito = all.filter { path -> 
        keep_mito.any { prefix -> path.getName().startsWith(prefix) }}
        .collect()
        .view()
  
    sgnl = all.filter { path -> 
        keep_sgnl.any { prefix -> path.getName().startsWith(prefix) }}
        .collect()
        .view()

    full = all.collect().mix(sgnl, mito)


    amalg = RUN_AMALGAMATE(full, run_name)


    
    emit:
    mito
    sgnl
    amalg

}