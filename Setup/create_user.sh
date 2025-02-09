#!/usr/bin/env bash

set -e

# 1. Check if run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with sudo."
    exit 1
fi

# 2. Check argument count
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME="$1"

#################################
# Ensure 'sudo' is installed
#################################
echo "Checking if 'sudo' is installed..."
if ! command -v sudo &>/dev/null; then
    echo "'sudo' not found. Installing..."
    apt-get update
    apt-get install -y sudo
    echo "'sudo' has been installed."
else
    echo "'sudo' is already installed."
fi

#################################
# Create the user (if needed)
#################################
if id "$USERNAME" &>/dev/null; then
    echo "User '$USERNAME' already exists."
else
    echo "Creating user '$USERNAME'..."
    adduser --gecos "" --disabled-password "$USERNAME"
fi

#################################
# Prompt for and set password
#################################
read -s -p "Enter password for user '$USERNAME': " PASSWORD
echo
read -s -p "Confirm password for user '$USERNAME': " PASSWORD_CONFIRM
echo

if [[ "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
    echo "Error: Passwords do not match."
    exit 1
fi

echo "Setting password for user '$USERNAME'..."
echo "$USERNAME:$PASSWORD" | chpasswd

#################################
# Add user to sudo group
#################################
echo "Adding user '$USERNAME' to 'sudo' group..."
usermod -aG sudo "$USERNAME"

echo "Done! User '$USERNAME' has been created (if needed) and granted sudo privileges."
