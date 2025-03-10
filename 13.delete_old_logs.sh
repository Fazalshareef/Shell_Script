#!/bin/bash

# Define the log directory (modify as needed)
LOG_DIR="/var/log"

# Define the file extension to be deleted
LOG_EXT=".logs"

# Define the age limit (in days)
DAYS=10

# Define color codes for output messages
R="\e[31m"   # Red for failure
G="\e[32m"   # Green for success
Y="\e[33m"   # Yellow for warning
N="\e[0m"    # Reset color

# Check if the script is run as root
if [ $(id -u) -ne 0 ]; then
    echo -e "$R Error: Please run as root! $N"
    exit 1
fi

# Check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo -e "$R Error: Directory $LOG_DIR does not exist! $N"
    exit 1
fi

# Find and delete log files older than 10 days
echo -e "$Y Searching for .logs files older than $DAYS days in $LOG_DIR... $N"
find "$LOG_DIR" -type f -name "*$LOG_EXT" -mtime +$DAYS -exec rm -f {} \;

# Validate if files were deleted
if [ $? -eq 0 ]; then
    echo -e "$G Successfully deleted old .logs files older than $DAYS days! $N"
else
    echo -e "$R Failed to delete some files! $N"
fi
