#!/bin/sh

docker run --rm -it \
        -u $(id -u $USER):$(id -u $USER) \
        -w="/home/$USER" \
        --mount type=bind,src=/etc/passwd,dst=/etc/passwd,ro \
        --mount type=bind,src=/etc/group,dst=/etc/group,ro \
        --mount type=bind,src=/etc/shadow,dst=/etc/shadow,ro \
        --mount type=bind,src=`pwd`/homedir,dst=/home/$USER \
        -p 15900:15900 \
        kicad_desktop_docker
