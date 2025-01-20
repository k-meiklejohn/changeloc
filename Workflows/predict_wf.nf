//workflow module taking fasta file and running through each prediction software.

//include processes from /Modules to run each process
include {RUN_MITOFATES} from '../Modules/Mitofates/mitofates.nf'
include {RUN_WOLFPSORT} from '../Modules/WoLFPSort/wolfpsort.nf'
include {RUN_TPPRED3} from '../Modules/TPpred3.0/tppred3.nf'
include {RUN_DEEPLOC2} from '../Modules/Deeploc2/deeploc2.nf'
include {RUN_SIGNALP6} from '../Modules/SignalP6.0/signalp6.nf'
include {RUN_TARGETP2} from '../Modules/TargetP2.0/targetp2.nf'
include { RUN_TMHMM2 } from '../Modules/TMHMM2.0/tmhmm2.nf'



//include {RUN_} from '../Modules/.nf'


workflow WF_PREDICT {
    take:
    split_files
    run_name

    main:

    prediction = Channel.empty()
    if (params.run_mitofates) {
        def mitofates = RUN_MITOFATES(split_files, params.org_mitofates, run_name)
            .collectFile(name: "mitofates.out")
        prediction = prediction.mix(mitofates)
    }

    if (params.run_wolfpsort) {
        def wolfpsort = RUN_WOLFPSORT(split_files, params.org_wolfpsort, run_name)
            .collectFile(name: "wolfpsort.out", skip: 1)
        prediction = prediction.mix(wolfpsort)
    }

    if (params.run_tppred3) {
        def tppred3 = RUN_TPPRED3(split_files, params.org_tppred3, run_name)
            .collectFile(name: "tppred3.out", skip: 1)
        prediction = prediction.mix(tppred3)
    }

    if (params.run_deeploc2) {
        def deeploc2 = RUN_DEEPLOC2(split_files, params.deeploc2_model, run_name)
            .collectFile(name: "deeploc2.out")
        prediction = prediction.mix(deeploc2)
    }

    if (params.run_targetp2) {
        def targetp2 = RUN_TARGETP2(split_files, params.org_tagetp2, run_name)
            .collectFile(name: "targetp2.out", skip: 1)
        prediction = prediction.mix(targetp2)
    }

    if (params.run_signalp6) {
        def signalp6 = RUN_SIGNALP6(split_files, params.signalp6_model, params.org_signalp6, run_name)
            .collectFile(name: "signalp6.out", skip: 1)
        prediction = prediction.mix(signalp6)
    }
    
    if (params.run_tmhmm2) {
        def tmhmm2 = RUN_TMHMM2(split_files, run_name)
            .collectFile(name: "tmhmm2.out", skip: 1)
        prediction = prediction.mix(tmhmm2)
    }


    // Emit the combined prediction results
    emit:
    prediction
}
