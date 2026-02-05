#!/bin/bash

LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="$LOGS_DIR/$(basename "$0").log"


if [ ! -d $LOGS_DIR ]; then
echo "$LOGS_DIR does not exist"
exit 1
fi

FILES_TO_DELETE=$(find $LOGS_DIR -name "*.log" -type f -mtime +14)

#echo "$FILES_TO_DELETE"

if [ -z "$FILES_TO_DELETE" ]; then

echo "No files older than 14 days to delete"

else 
    while IFS= read -r filepath; do

    echo "Deleting file: $filepath" >>$LOGS_FILE
    rm -f $filepath
    echo "Deleted file: $filepath" >>$LOGS_FILE
    done <<<$FILES_TO_DELETE
fi