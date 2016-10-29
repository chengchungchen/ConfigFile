#!/bin/sh

#### This function to remove old file, sort by create date.
#### ex. rm_oldfile {filedir}/ {day}
####         rm_oldfile /123/567/ 8
function rm_oldfile() {
    file=$1
    n=$2
    n1=$(ls -1 $file* | wc -l)
    n2=$(ls -1 $file* | tail -$n | wc -l)
    n3=$(expr $n1 - $n2)

    ls -1 $file* | head -n $n3 | xargs -n 1 rm -f
}
