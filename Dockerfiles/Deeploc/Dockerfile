FROM python

#take zip file from folder
COPY deeploc-2.0.All.tar.gz .

#install deeploc
RUN pip install deeploc-2.0.All.tar.gz

#take test file for docker build
COPY build.fasta .

#run test file to dowload fast model
RUN deeploc2 -f build.fasta \

#run test file to download accurate model
# RUN deeploc2 -f build.fasta -m Accurate