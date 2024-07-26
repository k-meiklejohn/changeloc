
//include processes from /Modules to run each process
include {RUN_MITOFATES} from '../Modules/Mitofates/mitofates.nf'
include {RUN_TARGETP2} from '../Modules/TargetP2.0/targetp2.nf'
//include {RUN_ELM} from '../Modules/ELM/elm.nf'
include {RUN_WOLFPSORT} from '../Modules/WoLFPSort/wolfpsort.nf'
include {RUN_TPPRED3} from '../Modules/TPpred3.0/tppred3.nf'
include {RUN_DEEPLOC2} from '../Modules/Deeploc2/deeploc2.nf'

//include {RUN_ from '../Modules/.nf'


workflow WF_PREDICT {
    take:
    input_ch

    main:
    //RUN_ELM(input_ch)
    RUN_MITOFATES(input_ch)
    RUN_TARGETP2(input_ch)
    RUN_WOLFPSORT(input_ch)
    RUN_DEEPLOC2(input_ch)
    RUN_TPPRED3(input_ch)

}