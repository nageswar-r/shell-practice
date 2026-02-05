#!/bin/bash

SOURCE_DIR="/home/ec2-user/app-logs"
DESTINATION_DIR="/home/ec2-user/app-log-old"
LOGS_FILE="$DESTINATION_DIR/$(basename "$0").log"
DAYS=14

log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') | $1" >> "$LOGS_FILE"
}

# Ensure source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    log "Source directory $SOURCE_DIR does not exist"
    exit 1
fi

# Find files older than $DAYS
FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +$DAYS)

if [ -z "$FILES" ]; then
    log "No files to archive .. skipping"
else
    log "Files to archive: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DESTINATION_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "Archive name: $ZIP_FILE_NAME"

    # Create archive
    tar -zcvf "$ZIP_FILE_NAME" $FILES
    if [ $? -eq 0 ]; then
        log "Archival is success"

        # Delete files after archiving
        while IFS= read -r filepath; do
            log "Deleting file: $filepath"
            rm -f "$filepath"
            if [ $? -eq 0 ]; then
                log "Deleted file: $filepath"
            else
                log "Failed to delete file: $filepath"
            fi
        done <<< "$FILES"
    else
        log "Archival is Failure"
        exit 1
    fi
fi