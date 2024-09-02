FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    python3 \
    python3-pip \
    cpanminus && \
    rm -rf /var/lib/apt/lists/*

#install scipy for libsvm setup.py later    
RUN pip install scipy

# Download and extract libsvm
RUN wget https://www.csie.ntu.edu.tw/~cjlin/libsvm/libsvm-3.35.tar.gz -O /tmp/libsvm.tar.gz && \
    mkdir -p /usr/local/libsvm && \
    tar -xzf /tmp/libsvm.tar.gz -C /usr/local/libsvm --strip-components=1 && \
    rm /tmp/libsvm.tar.gz

# Compile libsvm
WORKDIR /usr/local/libsvm
RUN make

# Install Python bindings for libsvm
WORKDIR /usr/local/libsvm/python
RUN python3 setup.py install

# Ensure the libsvm binaries are in the system PATH
ENV PATH="/usr/local/libsvm:${PATH}"

#Install required Perl modules
RUN cpanm Math::Cephes Perl6::Slurp Inline::C

#Set the working Directory
WORKDIR /

# Download and extract Mitofates
RUN wget https://mitf.cbrc.pj.aist.go.jp/MitoFates/program/MitoFates_1.2.tar.gz && \
tar -xzvf MitoFates_1.2.tar.gz -C .

# Make the MitoFates script executable
RUN chmod 777 MitoFates
RUN chmod +x MitoFates/MitoFates.pl