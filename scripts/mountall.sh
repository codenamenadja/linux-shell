#!/bin/bash
LVNAMES=()
#    sudo mount /dev/myVG/$lvname ~/usb_myVG/$lvname

sequencial_mount(){
    for lvname in ${LVNAMES[*]}
    do
        echo "${lvname} to mount?(y to mount, n to unmount)"
        read permission
        if [ $permission == "y" ]
        then
            echo "$permission and, mounts $lvname."
            sudo mount /dev/mapper/myVG-$lvname ~/myVG_partitions/$lvname/
        elif [ $permission == "n" ]
        then
            echo "$permission and, umount $lvname."
            sudo umount /dev/mapper/myVG-$lvname 
        else
            echo "do noting on $lvname."
        fi
    done
}

pre_error_handler(){
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
    pre_error_handler
    sequencial_mount
}
main
