// main.nf
include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_CLEAN_RESULT as CLEAN_GEN} from './Workflows/clean-result_wf.nf'
include {WF_CLEAN_RESULT as CLEAN_MITO} from './Workflows/clean-result_wf.nf'
include {WF_CLEAN_RESULT as CLEAN_SGNL} from './Workflows/clean-result_wf.nf'
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
    all_prediction = WF_PREDICT(fasta, run_name)
    general = all_prediction.general_prediction
    mito = all_prediction.mito_prediction
    sgnl = all_prediction.sgnl_prediction

    // long table creation
    gen_long_table = CLEAN_GEN(general, run_name, map)
        .view()
    mito_long_table = CLEAN_MITO(mito, run_name, map)
        .view()
    sgnl_long_table = CLEAN_SGNL(sgnl, run_name, map)
        .view()

    // wide tables creation
    wide_table = WF_WIDE_TABLES(long_table, run_name)

}