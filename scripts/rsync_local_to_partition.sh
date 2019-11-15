#!/bin/bash
if [ -n "${1}" ] 
then
sudo lvm vgdisplay | grep ${1} && sudo rsync -av ~/local_${1}/ ~/plugged_stroage_${1}/ || echo "no ${1} found."
else
    echo "positional argument for VGNAME not provided."
fi
exit 0
