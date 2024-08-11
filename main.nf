// main.nf

include {WF_PREDICT} from './Workflows/predict_wf.nf'
include {WF_TABLE} from './Workflows/table_wf.nf'

// Define parameters
params.input = 'double.fasta'  // Input FASTA file
params.chunks = 1             // Number of chunks

// Main workflow
workflow {
    // Count the total number of sequences in the FASTA file
    total_sequences = file(params.input).countFasta()

    // Calculate the number of sequences per chunk
    chunk_size = Math.ceil(total_sequences / params.chunks).toInteger()
    
    // Split the FASTA file into chunks
    split_fasta = file(params.input).splitFasta(by: chunk_size, file: true)

    // send to prediction software
    prediction = WF_PREDICT(split_fasta)
    WF_TABLE(prediction)


//     // Start the next process only when the specific files are available
//     process startNextProcess {
//         input:
//         path files from specificFiles

//         script:
//         """
//         echo "Starting process with files: ${files}"
//         """
// }
}