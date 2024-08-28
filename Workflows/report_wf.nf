include {RUN_MITO_REPORT} from "../Modules/Data_handling/mito-report.nf"

workflow WF_REPORT {
    take:
    mito

    main:
    RUN_MITO_REPORT(mito)
}