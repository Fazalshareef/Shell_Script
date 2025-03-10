\#!/bin/bash

# Get the user ID
ID=$(id -u)

# Define color codes
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Normal (reset)

# Generate a timestamp for the log file
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "Script started executing at $TIMESTAMP" | tee -a $LOGFILE

# Function to validate command execution
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2...$R Failed $N" | tee -a $LOGFILE
        exit 1
    else
        echo -e "$2...$G Success $N" | tee -a $LOGFILE
    fi
}

# Check if the user is root
if [ $ID -ne 0 ]; then
    echo -e "$R Error: User is not root. Please run as root. $N" | tee -a $LOGFILE
    exit 1
else
    echo -e "$G User is root. Proceeding... $N" | tee -a $LOGFILE
fi

# Loop through all packages provided as arguments
for package in "$@"; do
    # Check if the package is already installed
    apt list --installed "$package" &>> $LOGFILE
    if [ $? -ne 0 ]; then
        echo -e "$Y Installing $package... $N" | tee -a $LOGFILE
        apt install -y "$package" &>> $LOGFILE
        VALIDATE $? "Installation of $package"
    else
        echo -e "$package is already installed... $Y SKIPPING $N" | tee -a $LOGFILE
    fi
done

echo "Script execution completed at $(date +%F-%H-%M-%S)" | tee -a $LOGFILE