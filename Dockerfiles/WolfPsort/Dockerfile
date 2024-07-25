FROM perl

RUN apt-get update && \
apt-get install -y git

WORKDIR /

RUN git clone https://github.com/fmaguire/WoLFPSort.git

RUN cp WoLFPSort/bin/binByPlatform/binary-i386/* WoLFPSort/bin/

ENV PATH="/WoLFPSort/bin/:${PATH}"
RUN chmod -R +x WoLFPSort/bin/
ENV LANG=""