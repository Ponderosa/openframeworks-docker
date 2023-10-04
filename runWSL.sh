#!/usr/bin/env bash

hostApps=${1:-"$(pwd)/../openframeworks-apps"}

docker run -it \
    -w /oF \
    -v /tmp/.X11-unix:/tmp/.X11-unix -v /mnt/wslg:/mnt/wslg \
    -e DISPLAY=$DISPLAY -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR -e PULSE_SERVER=$PULSE_SERVER \
    --gpus all \
    --mount type=bind,source="${hostApps}",target=/oF/apps/hostApps \
    open_frameworks