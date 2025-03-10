#!/bin/bash

# Get the user ID
ID=$(id -u)

# Define color codes for output messages
R="\e[31m"   # Red for failure
G="\e[32m"   # Green for success
Y="\e[33m"   # Yellow for skipping
N="\e[0m"    # Reset color

# Generate a timestamp for logging
TIMESTAMP=$(date +%F-%H-%M-%S)

# Define the log file location
LOGFILE="/tmp/$(basename $0)-$TIMESTAMP.log"

# Print script start time
echo "Script started executing at $TIMESTAMP"

# Function to validate the success or failure of commands
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2...$R Failed $N"   # Print failure message in red
    else
        echo -e "$2...$G Success $N"  # Print success message in green
    fi
}

# Check if the script is run as root
if [ $ID -ne 0 ]; then
    echo "User is not root, please provide root access"
    exit 1  # Exit the script if the user is not root
else
    echo "User is root"
fi

# Loop through each package provided as arguments
for package in "$@"; do 
    # Check if the package is already installed
    apt list --installed 2>/dev/null | grep -w "^$package/" > /dev/null
    if [ $? -ne 0 ]; then
        # Install the package if not installed
        apt install -y "$package"
        VALIDATE $? "Installation of $package"
    else
        # Print a message if the package is already installed
        echo -e "$package is already installed ... $Y SKIPPING $N"
    fi  
done
