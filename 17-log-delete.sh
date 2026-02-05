#!/bin/bash

LOGS_DIR=/home/ec2-user/app-logs
LOGS_FILE="$LOGS_DIR/$(basename "$0").log"


if [ ! -d $LOGS_DIR ]; then
echo "$LOGS_DIR does not exist"
exit 1
fi