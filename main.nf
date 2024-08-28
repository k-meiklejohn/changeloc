// main.nf
include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_LONG_TABLE} from './Workflows/long-table_wf.nf'
include {WF_DEF_SET} from './Workflows/def-set_wf.nf'
include {WF_SPLIT_FASTA} from './Workflows/split-fasta_wf.nf'
include {WF_WIDE_TABLES} from './Workflows/wide-tables_wf.nf'



// Main workflow
workflow{

    // Print parameters for debugging


    // Create a channel from the input FASTA files
    input_sets = Channel.fromPath(params.fasta)

    // Invoke WF_DEF_SET as a workflow to process the FASTA files
    concatenate_fa = WF_DEF_SET(input_sets)
                    .collectFile(newLine: true)

    split_fasta = WF_SPLIT_FASTA(concatenate_fa, params.chunks)

    // send to prediction software
    prediction = WF_PREDICT(split_fasta)

    // long table creation
    long_table = WF_LONG_TABLE(prediction)

    // wide tables creation
    wide_table = WF_WIDE_TABLES(long_table)

}