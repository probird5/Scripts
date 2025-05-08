#!/bin/bash

# Require root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root"
  exit 1
fi

# Print the logo
print_logo() {
    cat << "EOF"
______ _                 _ _                           _   _____          _        _ _ 
| ___ \ |               | | |                         | | |_   _|        | |      | | |
| |_/ / | ___   ___   __| | |__   ___  _   _ _ __   __| |   | | _ __  ___| |_ __ _| | |
| ___ \ |/ _ \ / _ \ / _` | '_ \ / _ \| | | | '_ \ / _` |   | || '_ \/ __| __/ _` | | |
| |_/ / | (_) | (_) | (_| | | | | (_) | |_| | | | | (_| |  _| || | | \__ \ || (_| | | |
\____/|_|\___/ \___/ \__,_|_| |_|\___/ \__,_|_| |_|\__,_|  \___/_| |_|___/\__\__,_|_|_|
                                                                                       
EOF
}

# Clear screen and show logo
clear
print_logo

# Exit on any error
set -e

echo "Starting system setup..."

# Update the system first
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing docker compose"
sudo apt install docker-compose

echo "getting the latest version of bloodhound-ce"
wget https://github.com/SpecterOps/bloodhound-cli/releases/latest/download/bloodhound-cli-linux-amd64.tar.gz

echo "Unpacking bloodhound"
tar -xvzf bloodhound-cli-linux-amd64.tar.gz

echo "installing Bloodhound"
./bloodhound-cli install

echo "Setup complete!"

