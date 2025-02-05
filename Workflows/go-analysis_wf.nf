include { RUN_GO_ANALYSIS } from '../Modules/Analysis/go-analysis.nf'

workflow WF_GO_ANALYSIS{
take:
prediction
run_name

main:
output = RUN_GO_ANALYSIS(prediction, run_name)

emit:
output

}