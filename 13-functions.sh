#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0]; then
    echo " Please run this script with root user"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0]; then
        echo "$2 .. Failure"
        exit 1
    else
        echo "$2 .. Success"
    fi

}

dnf install nginx -y
VALIDATE $? "Installiing Nginx"
dnf install mysql -y
VALIDATE $? "Installing mysql"
dnf install nodejs -y
VALIDATE $? "Installing nodejs"