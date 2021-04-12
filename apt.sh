#!/bin/bash

apt update

apt install bash \
    bash-completion \
    bc \
    binutils \
    coreutils \
    dnsutils \
    file \
    grep \
    gzip \
    htop \
    less \
    nmap \
    rsync \
    sed \
    tmux \
    vim \
    wget \
    zip \
    algernon \
    busybox \
    binutils \
    ffmpeg \
    dropbear \
    lynx \
    make \
    nano \
    nodejs \
    pngquant \
    python \
    ranger \
    yarn \
    stow \
    man \
    git \
    zsh


pip install --upgrade pip
pip install youtube-dl requests

curl https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

#TODO: Make a python install script
#TODO: Rewrite for arch