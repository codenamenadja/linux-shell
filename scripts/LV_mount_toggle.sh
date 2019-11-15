#!/bin/bash
LVNAMES=()
sequencial_mount(){
    mkdir ~/plugged_storage_${1}
    for lvname in ${LVNAMES[*]}
    do
        echo "${lvname} on ${1} to mount?(y to mount, n to unmount)"
        read permission
        if [ $permission == "y" ]
        then
            mkdir ~/plugged_storage_${1}/$lvname
            echo "$permission and, mounts $lvname."
            sudo mount /dev/mapper/${1}-$lvname ~/plugged_storage_${1}/$lvname/
        elif [ $permission == "n" ]
        then
            echo "$permission and, umount $lvname."
            sudo umount /dev/mapper/${1}-$lvname 
            rmdir ~/plugged_storage_${1}/${lvname}
        else
            echo "do noting on $lvname."
        fi
    done
    rmdir ~/plugged_storage_${1}
}

pre_error_handler(){
if [ -z ${1} ]
then
    echo "positional argument VG name not specified."
    exit 0
fi

vgAvail=`sudo lvm vgscan | grep "${1}"`
if [ -z "$vgAvail" ]
then
    echo "VG-name you passed ${1}, not found."
    exit 0
fi

founds=`sudo lvm lvdisplay | grep "LV Name"`
all=($founds)
count=0
for key in ${all[*]}
do
    if [ ${key} != "LV" ] && [ ${key} != "Name" ] && [ ${key} != "ubuntu-lv" ]
    then
        LVNAMES[$count]=$key
        let "count+=1"
    fi
done
if [ ${#LVNAMES[@]} == 0 ]
then
    echo "no LV founds."
    exit 0  
fi
}

main(){
    pre_error_handler ${1}
    sequencial_mount ${1}
}
main ${1}
