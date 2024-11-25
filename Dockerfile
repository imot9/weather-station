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

RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Yocto configuration discourages root priviliges
RUN useradd -m yocto-user && chown -R yocto-user:yocto-user /yocto
USER yocto-user

RUN git clone https://github.com/openembedded/bitbake.git bitbake && \
    git clone -b kirkstone --single-branch https://github.com/openembedded/openembedded-core.git openembedded-core && \
    git clone -b kirkstone --single-branch https://github.com/agherzan/meta-raspberrypi.git meta-raspberrypi && \
    git clone -b kirkstone --single-branch https://github.com/openembedded/meta-openembedded.git meta-openembedded

RUN source openembedded-core/oe-init-build-env build && \
    bitbake --version
