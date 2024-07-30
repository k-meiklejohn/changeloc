# Use the Miniconda base image
FROM continuumio/miniconda3

# Set environment variables to prevent Python from writing .pyc files and reduce TensorFlow verbosity
ENV PYTHONDONTWRITEBYTECODE=true
ENV TF_CPP_MIN_LOG_LEVEL=3 DEEPMITO_ROOT=/deepmito PATH="/deepmito:${PATH}"

# Clone the deepmito repository
RUN git clone https://github.com/BolognaBiocomp/deepmito.git

# Update conda and install necessary packages
RUN conda update -n base conda && \
    conda install -n base python=3.8.5 && \
    conda install --yes nomkl keras==2.4.3 biopython==1.78 tensorflow==2.2.0 && \
    conda install --yes nomkl blast -c bioconda && \
    conda clean -afy

# Clean up unnecessary files
RUN find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

