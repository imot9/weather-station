FROM ubuntu:22.04

ENV YOCTO_DIR=/yocto

WORKDIR /yocto
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3 \
    python3-pip \
    chrpath \
    diffstat \
    texinfo \
    libncurses5-dev \
    wget \
    locales \
    cpio \
    file \
    gawk \
    lz4 \
    zstd \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/openembedded/bitbake.git bitbake && \
    git clone https://github.com/openembedded/openembedded-core.git openembedded-core && \
    git clone https://github.com/agherzan/meta-raspberrypi.git meta-raspberrypi && \
    git clone https://github.com/openembedded/meta-openembedded.git meta-openembedded
