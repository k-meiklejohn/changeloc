include {RUN_MITO_WIDE_TABLE} from "../Modules/Data_handling/mito-wide-table.nf"
include {RUN_WIDE_TABLE} from "../Modules/Data_handling/wide-table.nf"
include {RUN_SGNL_WIDE_TABLE} from "../Modules/Data_handling/sgnl-wide-table.nf"
include {RUN_AMALGAMATE} from "../Modules/Data_handling/amalgamate.nf"
include {RUN_AGGREGATE} from "../Modules/Data_handling/aggregate.nf"
include {RUN_AUTO_REPORT} from "../Modules/Report/auto-report.nf"

workflow WF_WIDE_TABLES{
    take:
    prediction
    run_name

    main:
    
    all_wide = RUN_WIDE_TABLE(prediction, run_name)
        .collect()
    mito_wide =  RUN_MITO_WIDE_TABLE(prediction, run_name)
        .collect()
    sgnl_wide = RUN_SGNL_WIDE_TABLE(prediction, run_name)
        .collect()

    wide = all_wide
                .mix(mito_wide, sgnl_wide)

    amalg = RUN_AMALGAMATE(wide, run_name)

    list_amalg = amalg.collect()
  
    full = RUN_AGGREGATE(list_amalg, run_name)
    
    report_in = amalg.mix(full)

    RUN_AUTO_REPORT(report_in, run_name)
}