#!/bin/bash - 

#echo $(hostname)
#echo $(dirname)
#echo $(dirname $0 $1)
echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo $(pwd)
