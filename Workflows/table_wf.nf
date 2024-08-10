include {RUN_TABLE} from "../Modules/Data_handling/table.nf"

workflow WF_TABLE{
    take:
    prediction

    main:
    csv = RUN_TABLE(prediction)

    emit:
    csv
}