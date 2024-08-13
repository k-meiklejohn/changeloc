include {RUN_LONG_TABLE} from "../Modules/Data_handling/long-table.nf"

workflow WF_LONG_TABLE{
    take:
    prediction

    main:
    tsv = RUN_LONG_TABLE(prediction)

    emit:
    tsv
}