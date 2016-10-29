#!/bin/sh
#### This script is to backup system configure.
#### It will include funciton file: ./funct.sh,
#### and loading backup file list: ./sys_{bsd/ubu/cent}_list.txt.
#### Write by Cheng-Chung, Chen at 2016.09.11.

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
export PATH

#### Setting variables. 
SCRIPT_ROOT="$(dirname $0)"
DATE="$(date +%Y%m%d-%H%M%S)"
BACKUP_TYPE="sys"
BACKUP_PATH="/backup/${BACKUP_TYPE}"
BACKUP_FILE="${BACKUP_PATH}/${BACKUP_TYPE}-${DATE}.tgz"

#### Include function file.
. ${SCRIPT_ROOT}/funct.sh

#### Read the backup file list.
FILE=""
while read line
do
    FILE="${FILE} ${line}"
done < ${SCRIPT_ROOT}/sys_bsd_list.txt

#### Verify the backup path.
if [ ! -d ${BACKUP_PATH} ]; then
    mkdir -p ${BACKUP_PATH}
fi

#### Compress and package backup files.
tar zcvf ${BACKUP_FILE} ${FILE} > /dev/null 2>&1

#### Delete old backup file.
rm_oldfile ${BACKUP_PATH}/ 7
