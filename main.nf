// main.nf
include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_TABLE} from './Workflows/table_wf.nf'
include {WF_DEF_SET} from './Workflows/def-set_wf.nf'
include {WF_SPLIT_FASTA} from './Workflows/split-fasta_wf.nf'

// Define parameters
params.input = "*.fasta"
params.chunks = 1             // Number of chunks

// Main workflow
workflow {
    // Create a channel from the input FASTA files
    input_sets = Channel.fromPath(params.input)

    // Invoke WF_DEF_SET as a workflow to process the FASTA files
    concatenate_fa = WF_DEF_SET(input_sets)
                    .collectFile(newLine: true)

    split_fasta = WF_SPLIT_FASTA(concatenate_fa, params.chunks)

    // send to prediction software
    prediction = WF_PREDICT(split_fasta)
    WF_TABLE(prediction)

}