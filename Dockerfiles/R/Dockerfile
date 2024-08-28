FROM r-base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y libssl-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libharfbuzz-dev libfribidi-dev
RUN apt-get install -y libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
RUN R -e "install.packages('seqinr')"
RUN R -e "install.packages('tidyverse')"