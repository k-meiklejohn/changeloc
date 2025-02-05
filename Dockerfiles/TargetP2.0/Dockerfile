# Use an official Perl runtime as a parent image
FROM ubuntu:20.04

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY targetP from current directory and extract
COPY targetp-2.0.Linux.tar.gz .
RUN tar -xvzf targetp-2.0.Linux.tar.gz \
&& rm targetp-2.0.Linux.tar.gz

#Put targetp on path and give permissions
ENV PATH="/targetp-2.0/bin:${PATH}"
RUN chmod +x /targetp-2.0/bin/targetp
