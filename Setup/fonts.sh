#!/bin/bash
# I need to test this out and edit this but it's good for now
#
#
# Updating package lists
echo "Updating package lists..."
sudo apt-get update

# Creating a temporary directory for the font download
TEMP_DIR=$(mktemp -d)
echo "Created a temporary directory: $TEMP_DIR"

# Change this URL to the font you want to download
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"

# Downloading the font
echo "Downloading font from $FONT_URL..."
wget -P "$TEMP_DIR" "$FONT_URL"

# Unzipping the font
echo "Unzipping the font..."
unzip "$TEMP_DIR"/*.zip -d "$TEMP_DIR"

# Creating local font directory if it doesn't exist
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Copying font files
echo "Copying font files to $FONT_DIR..."
cp "$TEMP_DIR"/*.ttf "$FONT_DIR"

# Cleaning up the temporary directory
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

# Updating font cache
echo "Updating font cache..."
fc-cache -fv

echo "Nerd Font installation complete!"

