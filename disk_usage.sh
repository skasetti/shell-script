#!/bin/bash

# colors
# validations
# log redirections

LOGFILE_DIRECTORY=/tmp
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[32m"
Y="\e[33m"

DISK_USAGE=$(df -hT |grep -vE 'tmpfs|Filesystem')
DISK_USAGE_THRESHOLD=1

#IFS= means internal field separator is space.
while IFS= read line
do
    # this command will give you usage in number format comparison
    usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
    # this command will give us partition
    partition=$(echo $line | awk '{print $1}')
    #now you need to check whether it is more than threshold ot not
    if [ $usage -gt $DISK_USAGE_THRESHOLD ];
    then
        message+="HIGH DISK USAGE ON $partition: $usage \n"
    fi    
done <<< $DISK_USAGE

    echo -e "message: $message"