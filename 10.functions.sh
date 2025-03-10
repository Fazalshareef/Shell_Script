#!/bin/bash

ID=$(id -u)

TIMESTAMP=$(date +%F-%H-%M-%S)

LOGFILE=/tmp/$0-$TIMESTAMP

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
    echo "ERROR :: $2 failed"
    exit 1
    else
    echo "SUCESS:: $2"
    fi

}

if [ $ID -ne 0 ]
 then 
  echo "User is not the root user, please provide the root acess"
  exit 1
 else
  echo "User is having the root acess"
 fi

apt install -y mysql-server &>> $LOGFILE

VALIDATE $? "Installing mysql"

apt install -y git &>> $LOGFILE

VALIDATE $? "Installing git"