include { RUN_AMALGAMATE } from '../Modules/Data_handling/amalgamate.nf'
include { RUN_AGGREGATE } from '../Modules/Data_handling/aggregate.nf'
include { RUN_AUTO_REPORT } from '../Modules/Report/auto-report.nf'

workflow WF_REPORT {
    take:
    amalg
    run_name

    main:
    
  
    // full = RUN_AGGREGATE(amalg.collect(), run_name)
    
    // report_in = amalg.mix(full)

    RUN_AUTO_REPORT(amalg, run_name)

}
