FROM continuumio/miniconda3   

ENV PYTHONDONTWRITEBYTECODE=true

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY targetP from P-tar-gzw directory and extract
COPY signalp-6.0h.fast.tar.gz .
RUN tar -xvzf signalp-6.0h.fast.tar.gz \
&& rm signalp-6.0h.fast.tar.gz

RUN conda update -n base -c defaults conda && \
    conda install -n base python=3.10 && \
    conda clean -afy

WORKDIR /signalp6_fast

RUN conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 "numpy<2" -c pytorch

RUN pip install signalp-6-package/

RUN cp -r signalp-6-package/models/* /opt/conda/lib/python3.10/site-packages/signalp/model_weights
