#!/bin/bash

USERID=$(id -u)
LOGS_FILE="/var/log/shell-script/$0/log"

if [ $USERID -ne 0 ]; then
    echo "Please run this script with root user" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){

    if [ $1 -ne 0 ]; then
        echo "$2 .. failed" | tee -a $LOGS_FILE
        exit 1
    else
        echo "$2 .. success" | tee -a $LOGS_FILE
    fi
}

for package in $@
do 
    dnf list installed $package &>> $LOGS_FILE
    if [ $? -ne 0 ]; then
        echo "$package is not installed, installing now"
        dnf install $package -y &>> $LOGS_FILE
        VALIDATE $? "$package installation"
    else 
        echo "$package is installed, skipping"
    fi
done