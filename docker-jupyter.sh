#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
    echo "No argument for port passed."
    exit
fi
port=$1
uid=$(id | sed -e 's/uid=\([0-9]\+\).*/\1/g')
gid=$(id | sed -e 's/.*gid=\([0-9]\+\).*/\1/g')

echo $uid $gid $USER

docker run --gpus all -it --rm --user root -e NB_USER=$USER -e NB_UID=$uid -e NB_GID=$gid -e GRANT_SUDO=yes -e JUPYTER_ENABLE_LAB=yes -p $port:8888 -v $(pwd):/home/$USER --name=gpu-jupyter-$USER gpu-jupyter-senprep start-notebook.sh 
