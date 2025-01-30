include { RUN_MITOFATES } from '../Modules/Prediction/Mitofates/mitofates.nf'
include { RUN_WOLFPSORT } from '../Modules/Prediction/WoLFPSort/wolfpsort.nf'
include { RUN_TPPRED3 } from '../Modules/Prediction/TPpred3.0/tppred3.nf'
include { RUN_DEEPLOC2 } from '../Modules/Prediction/Deeploc2/deeploc2.nf'
include { RUN_TARGETP2 } from '../Modules/Prediction/TargetP2.0/targetp2.nf'
include { RUN_SIGNALP6 } from '../Modules/Prediction/SignalP6.0/signalp6.nf'
include { RUN_TMHMM2 } from '../Modules/Prediction/TMHMM2.0/tmhmm2.nf'
//workflow module taking fasta file and running through each prediction software.



workflow WF_PREDICT {
    take:
    split_files
    run_name

    main:

    // initialise empty channel to take prediction outputs
    general_prediction = Channel.empty()
    mito_prediction = Channel.empty()
    sgnl_prediction = Channel.empty()

    // run each software if specified
    if (params.run_mitofates) {
        def mitofates = RUN_MITOFATES(split_files, params.org_mitofates, run_name)
            .collectFile(name: "mitofates.out")
        mito_prediction = mito_prediction.mix(mitofates)
        general_prediction = general_prediction.mix(mitofates)

    }

    if (params.run_wolfpsort) {
        def wolfpsort = RUN_WOLFPSORT(split_files, params.org_wolfpsort, run_name)
            .collectFile(name: "wolfpsort.out", skip: 1)
        mito_prediction = mito_prediction.mix(wolfpsort)
        sgnl_prediction = sgnl_prediction.mix(wolfpsort)
        general_prediction = general_prediction.mix(wolfpsort)

    }

    if (params.run_tppred3) {
        def tppred3 = RUN_TPPRED3(split_files, params.org_tppred3, run_name)
            .collectFile(name: "tppred3.out", skip: 1)
        mito_prediction = mito_prediction.mix(tppred3)
        general_prediction = general_prediction.mix(tppred3)

    }

    if (params.run_deeploc2) {
        def deeploc2 = RUN_DEEPLOC2(split_files, params.deeploc2_model, run_name)
            .collectFile(name: "deeploc2.out")
        mito_prediction = mito_prediction.mix(deeploc2)
        sgnl_prediction = sgnl_prediction.mix(deeploc2)
        general_prediction = general_prediction.mix(deeploc2)
    }

    if (params.run_targetp2) {
        def targetp2 = RUN_TARGETP2(split_files, params.org_targetp2, run_name)
            .collectFile(name: "targetp2.out", skip: 1)
        mito_prediction = mito_prediction.mix(targetp2)
        general_prediction = general_prediction.mix(targetp2)    
    }

    if (params.run_signalp6) {
        def signalp6 = RUN_SIGNALP6(split_files, params.signalp6_model, params.org_signalp6, run_name)
            .collectFile(name: "signalp6.out", skip: 1)
        sgnl_prediction = sgnl_prediction.mix(signalp6)
        general_prediction = general_prediction.mix(signalp6)    
    }
    
    if (params.run_tmhmm2) {
        def tmhmm2 = RUN_TMHMM2(split_files, run_name)
            .collectFile(name: "tmhmm2.out")
        sgnl_prediction = sgnl_prediction.mix(tmhmm2)
        general_prediction = general_prediction.mix(tmhmm2)
    }

    // Emit the combined prediction results
    emit:
    general_prediction
    sgnl_prediction
    mito_prediction
}
