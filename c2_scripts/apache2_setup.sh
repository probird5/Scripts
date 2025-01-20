#!/bin/bash

# Check if the script is being run as root
if (( EUID != 0 )); then
    echo "This script must be run as root. Please run it with sudo or as the root user."
    exit 1
fi

# Update repositories and upgrade packages
echo "Updating package repositories and upgrading packages..."
if apt update && apt upgrade -y; then
    echo "System updated and upgraded successfully."
else
    echo "Failed to update or upgrade packages." >&2
    exit 1
fi

sleep 3

# Install OpenSSH
echo "Installing OpenSSH..."
if apt install openssh-server -y; then
    echo "OpenSSH installed successfully."
else
    echo "OpenSSH installation failed." >&2
    exit 1
fi

# Prompt to continue installing Apache
read -p "Do you want to continue installing Apache? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Continuing with Apache installation..."
elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Exiting script..."
    exit 0
else
    echo "Invalid response. Exiting script."
    exit 1
fi

# Install Apache
echo "Installing Apache..."
if apt install apache2 -y; then
    echo "Apache installed successfully."
else
    echo "Apache installation failed." >&2
    exit 1
fi

# Prompt to enable modules and start Apache
read -p "Do you want to enable all required modules and start Apache? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Enabling modules and starting Apache..."
    if a2enmod ssl rewrite proxy proxy_http && systemctl restart apache2; then
        echo "Modules enabled and Apache restarted successfully."
    else
        echo "Failed to enable modules or restart Apache." >&2
        exit 1
    fi
elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Modules not enabled. Exiting script."
    exit 0
else
    echo "Invalid response. Exiting script."
    exit 1
fi



read -p "Do you want to enable SSL (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Enabling SSL..."
    if rm /etc/apache2/sites-enabled/000-default.conf && ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled && systemctl restart apache2; then
        echo "Enabled SSL on apache"
    else
        echo "Failed to enable SSH" >&2
        exit 1
    fi
elif [[ "$response" =~ ^[Nn]$ ]]; then
    echo "Modules not enabled. Exiting script."
    exit 0
else
    echo "Invalid response. Exiting script."
    exit 1
fi
