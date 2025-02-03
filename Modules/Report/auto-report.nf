process RUN_AUTO_REPORT {
publishDir "Output/${dir}/Reports", mode: "copy"
container "changeloc/python"

input:
path tsv
val dir

output:
path "*.html"

script:
"""
auto-report.py $tsv
"""
}