// main.nf

include {WF_PREDICT} from './Workflows/predict_wf.nf'


workflow {
    
    //split fasta file into chunks
    input_fa = Channel.fromPath('build.fasta')
                .splitFasta(by: 10,file: true)

    // send to prediction software
    WF_PREDICT(input_fa) 

}