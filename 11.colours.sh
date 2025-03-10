#!/bin/bash

# Get user ID
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/${0##*/}-$TIMESTAMP.log"  # Store logs in /tmp

# Define color codes
RED="\e[31m"
GREEN="\e[32m"
RESET="\e[0m"

# Validation function with color output
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "${RED}ERROR :: $2 failed${RESET}"
        exit 1
    else
        echo -e "${GREEN}SUCCESS :: $2${RESET}"
    fi
}

# Check if the user is root
if [ "$ID" -ne 0 ]; then
    echo -e "${RED}User is not the root user. Please provide root access.${RESET}"
    exit 1
else
    echo -e "${GREEN}User has root access.${RESET}"
fi

# Install MySQL Server
apt update >> $LOGFILE 2>&1
apt install -y mysql-server >> $LOGFILE 2>&1
VALIDATE $? "Installing MySQL"

# Install Git
apt install -y gifet >> $LOGFILE 2>&1
VALIDATE $? "Installing Git"
