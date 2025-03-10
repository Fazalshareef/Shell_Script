#!/bin/bash

ID=$(id -u)

if [ $? -ne 0 ]
 then 
  echo "Error :: Root acess is not there, please provide root acess and execute"
  exit 1 
  else 
   echo "Your are root user"
fi
sudo apt install -y yum

yum install mysql -y

echo [ $? -ne 0 ]
 then 
  echo "Error :: Installing Mysql is failed"

 else 
  echo "Installling Mysql is sucess"