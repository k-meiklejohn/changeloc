//workflow module taking fasta file and running through each prediciton software.

//include processes from /Modules to run each process
include {RUN_MITOFATES} from '../Modules/Mitofates/mitofates.nf'
include {RUN_WOLFPSORT} from '../Modules/WoLFPSort/wolfpsort.nf'
include {RUN_TPPRED3} from '../Modules/TPpred3.0/tppred3.nf'
include {RUN_DEEPLOC2} from '../Modules/Deeploc2/deeploc2.nf'
include {RUN_SIGNALP6} from '../Modules/SignalP6.0/signalp6.nf'
include {RUN_TARGETP2} from '../Modules/TargetP2.0/targetp2.nf'



//include {RUN_} from '../Modules/.nf'

workflow WF_PREDICT {
    take:
    split_files

    main:
    // send to each prediction software and collect files
    mitofates = RUN_MITOFATES(split_files)
        .collectFile(name: "mitofates.out")
    wolfpsort = RUN_WOLFPSORT(split_files)
        .collectFile(name: "wolfpsort.out", skip: 1)
    tppred3 = RUN_TPPRED3(split_files)
        .collectFile(name: "tppred3.out", skip: 1)
    if (params.fast == false){
    deeploc2 = RUN_DEEPLOC2(split_files)
        .collectFile(name: "deeploc2.out")
    }
    targetp2 = RUN_TARGETP2(split_files)
        .collectFile(name:"targetp2.out", skip: 1)
    signalp6 = RUN_SIGNALP6(split_files)
        .collectFile(name: "signalp6.out", skip: 1)

    // Merge all outputs into a single channel using `mix`

        if (params.fast == false){
            predictions = mitofates
                .mix(wolfpsort, tppred3, targetp2, signalp6, deeploc2)
        }
        else{
            predictions = mitofates
                .mix(wolfpsort, tppred3, targetp2, signalp6)
        }

    emit:
    predictions

}