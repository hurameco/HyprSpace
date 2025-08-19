#!/bin/bash

echo -e "Welcome to HyprSpace Installer!"
echo -e "This script will install and configure HyprSpace on your system."
echo -e "Please read the README.md file for more information."

echo -e "\nPress any key to continue... Ctrl+C to exit."
read -n 1 -s < /dev/tty
clear

# Default HyprSpace path
hyprspace_path="$HOME/.hyprspace"

# Check if the path exists
if [ -d "$hyprspace_path" ]; then
  # If the path exists, ask the user if they want to overwrite it
  echo -e "The path $hyprspace_path already exists.\nDo you want to overwrite it? (Y/n)"
  read -r overwrite < /dev/tty
  overwrite=${overwrite:-Y}  # Default to 'Y' if empty
  overwrite=$(echo "$overwrite" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
  if [ "$overwrite" != "y" ]; then
      echo -e "Exiting..."
      exit 1
  fi
  rm -rf "$hyprspace_path"
fi

# Install required packages
echo -e "Updating system..."
sudo pacman -Syu --noconfirm >/dev/null 2>&1
echo -e "Installing required packages..."
sudo pacman -S --noconfirm base-devel git >/dev/null 2>&1

# Clone the repository
echo -e "Cloning the HyprSpace repository..."

git clone --progress https://github.com/hurameco/hyprspace.git "$hyprspace_path" 2>&1
# Change directory to the cloned repository
cd "$hyprspace_path"

# # Run the installer
# source ./installer.sh

# logo
# info "Welcome to HyprSpace Installer!"
# read -n 1 -s < /dev/tty
# sleep 2
