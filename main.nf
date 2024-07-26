include {WF_PREDICT} from './Workflows/predict.nf'

input_fa = channel.fromPath("build.fasta")

workflow {
    
input_fa = channel.fromPath("build.fasta")

WF_PREDICT(input_fa)

}