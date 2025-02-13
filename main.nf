// main.nf
include { WF_PREDICT } from './Workflows/predict_wf.nf'
include { WF_CLEAN_RESULT } from './Workflows/clean-result_wf.nf'
include { WF_WIDE_TABLES } from './Workflows/wide-tables_wf.nf'
include { WF_PROCESS_FASTA } from './Workflows/process-fasta_wf.nf'
include { WF_REPORT } from './Workflows/report_wf.nf'
include { WF_GO_ANALYSIS } from './Workflows/go-analysis_wf.nf'

// Main workflow
workflow{
    
    currentDate = new Date().format("yyyy-MM-dd_HH-mm-ss")
    if (params.name == null){
        run_name = "${currentDate}-[${workflow.runName}]"
    }
    else if (params.name == "test") {
        run_name = "test"
    }
    else {
    run_name = "${currentDate}_${params.name}-[${workflow.runName}]"
    }

    println("Files will be saved to 'Output/${run_name}'")
    
    process_fasta = WF_PROCESS_FASTA(run_name)

    // send to prediction software
    prediction = WF_PREDICT(process_fasta.fasta, run_name)


    // long table creation
    long_table = WF_CLEAN_RESULT(prediction, run_name, process_fasta.map)

    // wide tables creation
    compare = WF_WIDE_TABLES(long_table, run_name)

    // gene onotolgy enrichemnt analysis
    WF_GO_ANALYSIS(compare.amalg, run_name)

    // generate a basic auto report
    WF_REPORT(compare.amalg, run_name)

}