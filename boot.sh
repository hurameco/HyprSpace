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
sudo pacman -Syu --noconfirm 2>&1 | while IFS= read -r line; do
    if [[ "$line" =~ Total:\ *([0-9]+)/([0-9]+) ]]; then
        printf "\rDownloading: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]} packages"
    elif [[ "$line" =~ \(([0-9]+)/([0-9]+)\) ]]; then
        printf "\rInstalling: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]} packages"
    fi
done
echo -e "Installing required packages..."
sudo pacman -Syu --noconfirm base-devel git 2>&1 | while IFS= read -r line; do
    if [[ "$line" =~ Total:\ *([0-9]+)/([0-9]+) ]]; then
        printf "\rDownloading: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]} packages"
    elif [[ "$line" =~ \(([0-9]+)/([0-9]+)\) ]]; then
        printf "\rInstalling: ${BASH_REMATCH[1]}/${BASH_REMATCH[2]} packages"
    fi
done

# Clone the repository
echo -e "Cloning the HyprSpace repository..."

git clone --progress https://github.com/hurameco/hyprspace.git "$hyprspace_path" 2>&1
# Change directory to the cloned repository
cd "$hyprspace_path" || { echo "Error: Failed to change to $hyprspace_path"; exit 1; }

# Run the installer
echo "Loading utilities..."
source "$hyprspace_path/core/utils.sh" || { echo "Error: Failed to source utils.sh"; exit 1; }
echo "Running installer..."
source "$hyprspace_path/installer.sh" || { echo "Error: Failed to source installer.sh"; exit 1; }

# logo
# info "Welcome to HyprSpace Installer!"
# read -n 1 -s < /dev/tty
# sleep 2
