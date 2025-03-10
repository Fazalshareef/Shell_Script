#!/bin/bash

# Define threshold percentage (Change as needed)
THRESHOLD=40

# Define the email address for alerts (Change as needed)
EMAIL="mohammedfazalshareef@gmail.com"

# Define color codes for output messages
R="\e[31m"   # Red for critical alert
G="\e[32m"   # Green for normal status
Y="\e[33m"   # Yellow for warnings
N="\e[0m"    # Reset color

# Get disk usage percentage for root partition
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Function to send an email alert (requires mailx or mailutils installed)
send_alert() {
    echo -e "Subject: Disk Usage Alert - $DISK_USAGE% Used\n\nWarning! Disk usage has exceeded the threshold of $THRESHOLD%. Current usage: $DISK_USAGE%." | mail -s "Disk Usage Alert" $EMAIL
}

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo -e "$R WARNING: Disk usage is at $DISK_USAGE%! Please take action! $N"
    send_alert
else
    echo -e "$G Disk usage is normal: $DISK_USAGE% $N"
fi
