include {RUN_LONG_TABLE} from "../Modules/Data_handling/long-table.nf"

workflow WF_LONG_TABLE{
    take:
    prediction
    run_name

    main:
    tsv = RUN_LONG_TABLE(prediction, run_name)

    emit:
    tsv
}