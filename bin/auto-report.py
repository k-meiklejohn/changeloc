#!/bin/env python

import pandas as pd
from ydata_profiling import ProfileReport
import re
import sys

# Define TSV file
tsv_file = sys.argv[1]

print(tsv_file)
# Extract the name from the file name
name = re.search(r'^\w+', tsv_file).group()

print(name)

# Read the TSV file into a DataFrame
df = pd.read_csv(tsv_file, sep='\\t') 

# Create a profiling report
profile = ProfileReport(df, title=(name + " Report"))

# Save the report to an HTML file
profile.to_file(name + ".auto_report.html")