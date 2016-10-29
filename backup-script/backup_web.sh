#!/bin/sh
#### This script is to backup the web data
#### It will include funciton file: ./funct.sh,
#### and loading web list: ./web_list.txt
#### Write by Cheng-Chung, Chen at 2016.09.11.

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
export PATH

#### Setting variables.
SCRIPT_ROOT="$(dirname $0)"
DATE="$(date +%Y%m%d-%H%M%S)"
BACKUP_TYPE="web"

#### Include function file.
. ${SCRIPT_ROOT}/funct.sh

while read line
do
    WEB_DIR="${line}"
    WEB_PATH="/home/www"
    BACKUP_PATH="/backup/${BACKUP_TYPE}/${WEB_DIR}"
    BACKUP_FILE="${BACKUP_PATH}/${WEB_DIR}-${DATE}.tgz"

    #### Verify the backup path
    if [ ! -d ${BACKUP_PATH} ]; then
        mkdir -p ${BACKUP_PATH}
    fi

    #### Compress and package backup files
    tar zcvf ${BACKUP_FILE} ${WEB_PATH}/${WEB_DIR} > /dev/null 2>&1

    #### Delete old backup file
    rm_oldfile ${BACKUP_PATH}/ 7
done < ${SCRIPT_ROOT}/web_list.txt
