include {RUN_DEF_SET} from "../Modules/Data_handling/def-set.nf"

workflow WF_DEF_SET {
take:
fasta
run_name

main:
output = RUN_DEF_SET(fasta, run_name)

emit:
output

}