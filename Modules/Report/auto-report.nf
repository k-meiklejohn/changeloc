process RUN_AUTO_REPORT {
publishDir "Reports"
container "changeloc/python"

input:
path tsv

output:
path "*.html"

"""
auto-report.py $tsv
"""
}