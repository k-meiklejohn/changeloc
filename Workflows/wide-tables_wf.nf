include { RUN_WIDE_TABLE } from '../Modules/Data_handling/wide-table.nf'
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
    
    // keep_general = [
    //     "deeploc2",
    //     "wolpsort"
    // ]
    
    
    // pivot table to ease comparison
    every = RUN_WIDE_TABLE(prediction, run_name)

    // filter out mito files
    mito = every.filter { path -> path.getName().contains(".mito") }.filter { path -> 
        keep_mito.any { prefix -> path.getName().startsWith(prefix) }}
        .collect()

    // filter out signal files
    sgnl = every.filter { path -> path.getName().contains(".sgnl") }.filter { path -> 
        keep_sgnl.any { prefix -> path.getName().startsWith(prefix) }}
        .collect()

    // filter out files with all possible abbreviations
    all = every.filter { path -> path.getName().contains(".all") }

    // // filter out files from all that use general software
    // general = all.filter { path -> 
    //     keep_general.any { prefix -> path.getName().startsWith(prefix) }}
    //     .collect()

    full = mito.mix(sgnl, mito, all.collect())


    amalg = RUN_AMALGAMATE(full, run_name, params.threshold)

 
    emit:
    mito
    sgnl
    amalg

}