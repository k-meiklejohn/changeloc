//workflow module taking fasta file and running through each prediction software.

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
        rmitofates = false
        rwolfpsort = false
        rtppred3 = false
        rdeeploc2 = false
        rtargetp2 = false
        rsignalp6 = false

    // Set parameters based on the selected software
    if (params.software == "all") {
            rmitofates = true
            rwolfpsort = true
            rtppred3 = true
            rdeeploc2 = true
            rtargetp2 = true
            rsignalp6 = true
    } else if (params.software == "mito-only") {
            rmitofates = true
            rtppred3 = true
            rtargetp2 = true
    } else if (params.software == "general-only") {
            rwolfpsort = true
            rdeeploc2 = true
    } else if (params.software == "signal-only") {
            rwolfpsort = true
            rdeeploc2 = true
            rtargetp2 = true
            rsignalp6 = true
    } else if (params.software == "quick") {
            println("logic working")
            rmitofates = true
            rwolfpsort = true
            rtppred3 = true
    }

    prediction = Channel.empty()
    if (rmitofates) {
        def mitofates = RUN_MITOFATES(split_files)
            .collectFile(name: "mitofates.out")
        prediction = prediction.mix(mitofates)
    }

    if (rwolfpsort) {
        def wolfpsort = RUN_WOLFPSORT(split_files)
            .collectFile(name: "wolfpsort.out", skip: 1)
        prediction = prediction.mix(wolfpsort)
    }

    if (rtppred3) {
        def tppred3 = RUN_TPPRED3(split_files)
            .collectFile(name: "tppred3.out", skip: 1)
        prediction = prediction.mix(tppred3)
    }

    if (rdeeploc2) {
        def deeploc2 = RUN_DEEPLOC2(split_files)
            .collectFile(name: "deeploc2.out")
        prediction = prediction.mix(deeploc2)
    }

    if (rtargetp2) {
        def targetp2 = RUN_TARGETP2(split_files)
            .collectFile(name: "targetp2.out", skip: 1)
        prediction = prediction.mix(targetp2)
    }

    if (rsignalp6) {
        def signalp6 = RUN_SIGNALP6(split_files)
            .collectFile(name: "signalp6.out", skip: 1)
        prediction = prediction.mix(signalp6)
    }


    // Emit the combined prediction results
    emit:
    prediction
}
