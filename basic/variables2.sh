#!/bin/bash

a=879
echo "\$a = $a"
let a=16+5
echo "\$a = $a"

echo "loop a!"
for a in 1 2 3 4
do
    echo "input plz..."
    read input
    echo "a=$a and input=$input"
done

echo 'a=`echo Hello!`'
a=`echo Hello!`
echo $a

echo 'a=`ls -l`'
a=`ls -l|grep '.sh'`
echo $a

exit 0
