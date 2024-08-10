// main.nf

include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_TABLE} from './Workflows/table_wf.nf'


workflow {
    
    //split fasta file into chunks
    input_fa = Channel.fromPath('double.fasta')
                .splitFasta(by: 10,file: true)

    // send to prediction software
    prediction = WF_PREDICT(input_fa)
    WF_TABLE(prediction)
}