# Base Image
FROM continuumio/miniconda3

ENV PYTHONDONTWRITEBYTECODE=true

RUN git clone https://github.com/BolognaBiocomp/deepmito.git

RUN conda update -n base conda && \
   conda install --yes nomkl keras==2.4.3 biopython==1.78 tensorflow==2.2.0 && \
   conda install --yes nomkl blast -c bioconda && \
   conda clean -afy \
   && find /opt/conda/ -follow -type f -name '*.a' -delete \
   && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
   && find /opt/conda/ -follow -type f -name '*.js.map' -delete

# Verbosity level of Tensorflow
ENV TF_CPP_MIN_LOG_LEVEL=3 DEEPMITO_ROOT=deepmito PATH=deepmito:$PATH