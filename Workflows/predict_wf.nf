//workflow module taking fasta file and running through each prediciton software.

//include processes from /Modules to run each process
include {RUN_MITOFATES} from '../Modules/Mitofates/mitofates.nf'
include {RUN_WOLFPSORT} from '../Modules/WoLFPSort/wolfpsort.nf'
include {RUN_TPPRED3} from '../Modules/TPpred3.0/tppred3.nf'
// include {RUN_DEEPLOC2} from '../Modules/Deeploc2/deeploc2.nf'
// include {RUN_SIGNALP6} from '../Modules/SignalP6.0/signalp6.nf'
// include {RUN_TARGETP2} from '../Modules/TargetP2.0/targetp2.nf'



//include {RUN_} from '../Modules/.nf'

workflow WF_PREDICT {
    take:
    split_files

    main:
    // send to each prediction software and collect files
    mitofates = RUN_MITOFATES(split_files)
        .collectFile()
    wolfpsort = RUN_WOLFPSORT(split_files)
        .collectFile()
    tppred3 = RUN_TPPRED3(split_files)
        .collectFile()
    // deeploc2 = RUN_DEEPLOC2(split_files)
    //     .collectFile()
    // targetp2 = RUN_TARGETP2(split_files)
    //     .collectFile()
    // signalp6 = RUN_SIGNALP6(split_files)
    //     .collectFile()

    // output predicitons files as tuple
    predictions = tuple( mitofates, wolfpsort, tppred3 ) //,deeploc2, signalp6, targetp2

    emit:
    predictions

}