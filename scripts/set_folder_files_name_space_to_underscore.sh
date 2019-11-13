#!/bin/bash
echo "which directory would you like to check?"
read directory #variable
    find $directory -type f | while read file; do
        if [[ "$file" = *[[:space:]]* ]]; then
        mv "$file" `echo $file | tr ' ' '_'`
    fi;
done
