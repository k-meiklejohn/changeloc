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
    


    prediction_mito = prediction.filter { path -> 
        keep_mito.any { prefix -> path.getName().startsWith(prefix) }}
    prediction_sgnl = prediction.filter { path -> 
        keep_sgnl.any { prefix -> path.getName().startsWith(prefix) }}


    all_wide = RUN_WIDE_TABLE(prediction, run_name)
        .collect()
    mito_wide =  RUN_MITO_WIDE_TABLE(prediction_mito, run_name)
        .collect()
    sgnl_wide = RUN_SGNL_WIDE_TABLE(prediction_sgnl, run_name)
        .collect()

    wide = all_wide
                .mix(mito_wide, sgnl_wide)

    amalg = RUN_AMALGAMATE(wide, run_name)

    list_amalg = amalg.collect()
  
    full = RUN_AGGREGATE(list_amalg, run_name)
    
    report_in = amalg.mix(full)

    RUN_AUTO_REPORT(report_in, run_name)
}