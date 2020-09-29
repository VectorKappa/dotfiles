#!/data/data/com.termux/files/usr/bin/bash

# Install command-line tools using Apt.

# Make sure we’re using the latest Apt.
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
    mc \
    nmap \
    openssh \
    openssl \
    python2 \
    rsync \
    sed \
    tmux \
    vim \
    wget \
    zip

pkg install unstable-repo
pkg install x11-repo
pkg install algernon
pkg list-installed
pkg install busybox
pkg install binutils
pkg install ffmpeg
pkg install vim
pkg install dropbear
pkg install lynx make nano nmap nodejs nsnake nudoku pngquant python ranger termux-api termux-auth vitetris
pkg install wol wget
pip install youtube-dl requests
pip install --upgrade pip
pkg install yarn
pkg install stow
pkg install man
pkg install tmux