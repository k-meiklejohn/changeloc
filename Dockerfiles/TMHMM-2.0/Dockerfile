# Use an official Perl runtime as a parent image
FROM perl:5.32

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    gnuplot \
    ghostscript \
    netpbm \
    wget \
    make \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY tmhmm-2.0c.Linux.tar.gz .

RUN tar -xvzf tmhmm-2.0c.Linux.tar.gz \
&& rm tmhmm-2.0c.Linux.tar.gz

# Add tmhmm to PATH
ENV PATH="/tmhmm-2.0c/bin/:${PATH}"

# Ensure the decodeanhmm binary is executable
RUN chmod +x tmhmm-2.0c/bin/decodeanhmm.Linux_x86_64

# Ensure the Perl scripts are executable
RUN chmod +x tmhmm-2.0c/bin/tmhmm tmhmm-2.0c/bin/tmhmmformat.pl

# Copy a test protein sequence file if needed
COPY CDS.fasta .