// main.nf
include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_CLEAN_RESULT} from './Workflows/clean-result_wf.nf'
include {WF_WIDE_TABLES} from './Workflows/wide-tables_wf.nf'
include { WF_PROCESS_FASTA } from './Workflows/process-fasta_wf.nf'

// Main workflow
workflow{


    // Create a channel from the input FASTA files
    input_sets = Channel.fromPath(params.fasta)
    
    currentDate = new Date().format("yyyy-MM-dd_HH-mm-ss")
    if (params.name == null){
        run_name = "${currentDate}-[${workflow.runName}]"
    }
    else{
        run_name = "${currentDate}_${params.name}-[${workflow.runName}]"
    }

    println("Files will be saved to 'Output/${run_name}'")


    process_fasta = WF_PROCESS_FASTA(input_sets, run_name, params.chunks)
    map = process_fasta.map
    fasta = process_fasta.fasta


    // send to prediction software
    prediction = WF_PREDICT(fasta, run_name)

    // long table creation
    long_table = WF_CLEAN_RESULT(prediction, run_name, map)

    // wide tables creation
    WF_WIDE_TABLES(long_table, run_name)

}