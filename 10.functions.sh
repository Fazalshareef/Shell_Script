#!bin/bash

ID=$(id-u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
    echo "ERROR :: $2 failed"
    else
    echo "ERROR :: $2...sucess"
    fi

}

if [ ID -ne 0 ]
 then 
  echo "User is not the root user, please provide the root acess"
 else
  echo "User is having the root acess"
 fi

apt install -y mysql-server

VALIDATE $? "Installing mysql"

apt install -y git

VALIDATE $? "Installing git"