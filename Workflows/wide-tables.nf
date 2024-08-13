include {RUN_MITO_WIDE_TABLE} from "../Modules/Data_handling/mito-wide-table.nf"
include {RUN_WIDE_TABLE} from "../Modules/Data_handling/wide-table.nf"
include {RUN_SGNL_WIDE_TABLE} from "../Modules/Data_handling/sgnl-wide-table.nf"

workflow WF_WIDE_TABLES{
    take:
    prediction

    main:
    wide = RUN_WIDE_TABLE(prediction)
    mito_wide =  RUN_MITO_WIDE_TABLE(prediction)
    sgnl_wide = RUN_SGNL_WIDE_TABLE(prediction)

    emit:
    wide
    mito_wide
    sgnl_wide
    
}