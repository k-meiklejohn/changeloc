#This seems to work, docker image also already available

# Base Image
FROM continuumio/miniconda3:4.7.12

RUN git clone https://github.com/BolognaBiocomp/tppred3

RUN conda update -n base conda && \
   conda install --yes nomkl meme emboss -c bioconda && \
   conda install --yes nomkl libsvm -c conda-forge && \
   conda install --yes nomkl libiconv biopython && \
   conda clean -afy \
   && find /opt/conda/ -follow -type f -name '*.a' -delete \
   && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
   && find /opt/conda/ -follow -type f -name '*.js.map' -delete

   ENV PYTHONDONTWRITEBYTECODE=true TPPRED_ROOT=/tppred3 PATH="tppred3:$PATH"