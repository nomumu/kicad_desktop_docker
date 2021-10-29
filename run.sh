#!/usr/bin/env bash

CONTAINER_NAME=${1:-kicad_desktop}
NOVNC_PORT=${2:-15900}

docker run --name $CONTAINER_NAME \
	--rm -itd \
        -u $(id -u $USER):$(id -u $USER) \
        -w="/home/$USER" \
        --mount type=bind,src=/etc/passwd,dst=/etc/passwd,ro \
        --mount type=bind,src=/etc/group,dst=/etc/group,ro \
        --mount type=bind,src=/etc/shadow,dst=/etc/shadow,ro \
        --mount type=bind,src=`pwd`/homedir,dst=/home/$USER \
        -p $NOVNC_PORT:15900 \
	kicad_desktop_docker
