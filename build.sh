#!/usr/bin/env bash

set -euo pipefail

# openFrameworks variables
of_folder=openFrameworks
of_version="0.12.0"
of_releases=https://github.com/openframeworks/openFrameworks/releases/download

# Supported Architectures
x86_64=x86_64
arm64=aarch64

# Check if the directory exists; if not, create it
if [ ! -d "$of_folder" ]; then
    mkdir -p "$of_folder"
fi

# Check architecture
arch="$(uname -m)"

if [ "$arch" == "$x86_64" ]; then
    echo "You are running an x86 64-bit system"
    of_tar=of_v${of_version}_linux64gcc6_release.tar.gz
elif [ "$arch" == "$arm64" ]; then
    echo "You are running a 64bit ARM system."
    of_tar=of_v${of_version}_linuxaarch64_release.tar.gz
elif [ "$arch" == "i386" ] || [ "$arch" == "i686" ]; then
    echo "You are running a 32-bit system and this is not currently supported"
    exit 1
else
    echo "Unknown architecture: $arch"
    exit 1
fi

# Download openFrameworks
if [ ! -f "$of_folder/$of_tar" ]; then
    url=${of_releases}/${of_version}/${of_tar}
    echo Downloading openFrameworks ${url};
    curl -L ${url} -o "${of_folder}/${of_tar}";
else
    echo openFrameworks already downloaded
fi

# Unzip file
if [ ! -d "$of_folder/release" ]; then
    mkdir "$of_folder/release"
fi

if [ ! -d "$of_folder/release/scripts" ]; then
    echo extracting openFrameworks
    tar xzf "${of_folder}/${of_tar}" -C "${of_folder}/release" --strip-components 1
else
    echo openFrameworks already extracted
fi

# Build Docker Container
docker build -t open_frameworks -f Dockerfile.openFrameworks .