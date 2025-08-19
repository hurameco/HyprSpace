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
  overwrite = "y"
  echo -e "The path $hyprspace_path already exists.\nDo you want to overwrite it? (Y/n)"
  read -r overwrite
  if [ "$overwrite" != "y" ]; then
      echo -e "Exiting..."
      exit 1
  fi
fi

# Install required packages
sudo pacman -Syu --noconfirm >/dev/null 2>&1
sudo pacman -S --noconfirm base-devel git >/dev/null 2>&1

# Clone the repository
git clone https://github.com/hurameco/hyprspace.git "$hyprspace_path"

# Change directory to the cloned repository
cd "$hyprspace_path"

# Run the installer
source ./installer.sh


clear
logo
info "Welcome to HyprSpace Installer!"
sleep 2
