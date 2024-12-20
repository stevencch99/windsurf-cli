#!/bin/bash

# Default installation directory
DEFAULT_INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="windsurf"

# Check if a custom installation directory was provided
INSTALL_DIR="${1:-$DEFAULT_INSTALL_DIR}"

# Ensure the script is run from the correct directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating installation directory: $INSTALL_DIR"
    sudo mkdir -p "$INSTALL_DIR"
fi

# Copy the script to the installation directory
echo "Installing windsurf CLI to $INSTALL_DIR/$SCRIPT_NAME"
sudo cp "$SCRIPT_DIR/$SCRIPT_NAME" "$INSTALL_DIR/"

# Make the script executable
sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo "Installation complete! You can now use 'windsurf' command."
echo "Try 'windsurf --help' for usage information."
