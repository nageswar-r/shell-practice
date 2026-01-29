#!/bin/bash

USERID=$(id -u)
#LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "Please run this script from root user" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){

if [ $1 -ne 0 ]; then
    echo "$2 .. Failure" | tee -a $LOGS_FILE
    exit 1
else 
    echo "$2 .. Successs" | tee -a $LOGS_FILE

fi
}

for package in $@
do 
    dnf install $package -y &>> $LOGS_FILE
    VALIDATE $? "$Package installation"
done
