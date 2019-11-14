#!/bin/bash
if [ -n "${1}" ] 
then
sudo lvm vgdisplay | grep ${1} && sudo rsync -av ~/${1}_local/ ~/${1}_partitions/ || echo "no ${1} found."
else
    echo "positional argument for VGNAME not provided."
fi
exit 0
