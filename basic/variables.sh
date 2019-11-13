#!/bin/bash

a=375
hello=$a
echo $hello

hello="A B C   D"
echo $hello
hello=
echo "\$hello ( null ) = $hello"
echo "\$a = $a"
unset a
echo "\$a = $a"
exit 0
