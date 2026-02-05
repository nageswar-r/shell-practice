#!/bin/bash

USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/$0.log"
SOURCE_DIR=$1
DESTINATION_DIR=$2
DAYS=${3:-14} # 14 days is the default value, if the user not supplied

mkdir -p $LOGS_FOLDER

log(){
    echo "$(date "+%Y-%M-%D %H:%M:%S") | $1" | tee -a $LOGS_FILE
}

if [ $USER_ID -ne 0 ]; then
 echo "Please run this command with root user"
 exit 1
fi

usage(){
    log "USAGE:: sudo backup.sh <source_dir> <destination_dir> <days>[default 14 days]"
    exit 1
}

if [ $# -le 2 ]; then
usage
fi
if [ ! -d "$SOURCE_DIR" ]; then
log "Source directory: $SOURCE_DIR does not exist"
exit 1
fi

if [ ! -d "$DESTINATION_DIR" ]; then
log "Destination directory: "$DESTINATION_DIR" does not exist"
exit 1
fi

FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DESTINATION_DIR"
log "Days: $DAYS"

if [ -z "${FILES}" ]; then
    log "No files to archive .. skipping"
        else 
                log "Files to archive:$FILES"
                TIMESTAMP=$(date +%F-%H-%M-%S)
                ZIP_FILE_NAME="$DESTINATION_DIR/app-logs-$TIMESTAMP.tar.gz"
                log "Archieve name: $ZIP_FILE_NAME"
                #tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)
                #find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS -print0 | tar --null -zcvf "$ZIP_FILE_NAME" --files-from=-
tar -zcvf "$ZIP_FILE_NAME" $FILES
if [ $? -eq 0 ]; then
    log "Archival is success"
    while IFS= read -r filepath; do
        log "Deleting file: $filepath"
        rm -f "$filepath"
        log "Deleted file: $filepath"
    done <<< "$FILES"
else
    log "Archival is Failure"
    exit 1
fi

                # if [ -z $ZIP_FILE_NAME ]; then
                #     log "Archeival is success"

                #     while IFS= read -r filepath; do
                #     log "Deleting file:$filepath"
                #     rm -f $filepath
                #     log "Deleted file:$filepath"
                #     done <<< $FILES

                # else
                # log "Archeival is Failure"
                # exit 1
                # fi

fi