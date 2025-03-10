#!/bin/bash

ID=$(id -u)

if [ "$ID" -ne 0 ]; then
  echo "Error :: Root access is required. Please run as root."
  exit 1
else
  echo "You are a root user."
fi

# Install yum (optional for Ubuntu, as apt is preferred)
sudo apt update && sudo apt install -y yum

# Install MySQL using apt (for Ubuntu)
sudo apt install -y mysql-server

# Check if MySQL installation was successful
if [ $? -ne 0 ]; then
  echo "Error :: Installing MySQL failed"
  exit 1
else
  echo "Installing MySQL was successful"
fi
