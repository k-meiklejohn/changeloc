#base image
FROM nvidia/cuda:11.3.1-base-ubuntu20.04

RUN apt-get update && \
apt-get install -y \
python3 \
python3-pip 

RUN pip install "torch==1.8.0"

RUN apt-get install -y git

RUN git clone https://github.com/Wangbiub/GO-Submito.git

ENV PATH=GO-Submito:$PATH

RUN chmod +x GO-Submito/main424.py