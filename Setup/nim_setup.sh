#!/bin/bash

# Update the package list
sudo apt update

# Install essential tools
sudo apt install -y curl build-essential

# Download and install choosenim (a tool to manage Nim versions)
curl https://nim-lang.org/choosenim/init.sh -sSf | sh

# Add Nim to the PATH for this script session
export PATH=$HOME/.nimble/bin:$PATH

# Also add Nim to the PATH for future shell sessions
echo "export PATH=$HOME/.nimble/bin:$PATH" >> ~/.bashrc

# Install the latest stable version of Nim using choosenim
choosenim stable

# Verify the installation
nim --version

