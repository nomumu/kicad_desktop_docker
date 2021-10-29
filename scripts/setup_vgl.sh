#!/bin/bash

timeout=30
command="/opt/VirtualGL/bin/vglserver_config"
expect -c "
    set timeout ${timeout}
    spawn ${command}
    expect \"Choose\"
    send \"1\n\"
    expect \"\[Y/n\]\"
    send \"y\n\"
    expect \"\[Y/n\]\"
    send \"y\n\"
    expect \"\[Y/n\]\"
    send \"y\n\"
    expect \"\[Y/n\]\"
    send \"y\n\"
    expect \"Choose\"
    send \"x\n\"
    exit 0
"
exit 0

