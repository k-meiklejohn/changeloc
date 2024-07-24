FROM python

# Install necessary system packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY targetP from current directory and extract
COPY signalp-6.0h.fast.tar.gz .
RUN tar -xvzf signalp-6.0h.fast.tar.gz \
&& rm signalp-6.0h.fast.tar.gz

#Put targetp on path and give permissions
ENV PATH="/targetp-2.0/bin:${PATH}"
RUN chmod +x /targetp-2.0/bin/targetp

# RUN cp -r /targetp-2.0/bin/targetp /usr/local/bin/ && \
# chmod +x /usr/local/bin/targetp

