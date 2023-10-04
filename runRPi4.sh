#!/usr/bin/env bash

hostApps=${1:-"$(pwd)/../openframeworks-apps"}

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run -it \
    -w /oF \
    -v $XSOCK:$XSOCK -v $XAUTH:$XAUTH -v /run/user/$(id -u)/pulse:/run/pulse\
    -e "XAUTHORITY=${XAUTH}" -e "DISPLAY" \
    --device=/dev/dri:/dev/dri \
    --mount type=bind,source="${hostApps}",target=/oF/apps/hostApps \
    open_frameworks