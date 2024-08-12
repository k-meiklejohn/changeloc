include {RUN_DEF_SET} from "../Modules/Data_handling/def-set.nf"

workflow WF_DEF_SET {
take:
fasta

main:
output = RUN_DEF_SET(fasta)

emit:
output

}