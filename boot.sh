#!/bin/bash

clear

printf "Welcome to HyprSpace Installer!\n"
printf "This script will install and configure HyprSpace on your system.\n"
printf "Please read the README.md file for more information.\n"

printf "\nPress any key to continue... Ctrl+C to exit.\n"
read -n 1 -s < /dev/tty
clear

# Default HyprSpace path
hyprspace_path="$HOME/.hyprspace"

# Check if the path exists
if [ -d "$hyprspace_path" ]; then
  # If the path exists, ask the user if they want to overwrite it
  printf "The path %s already exists.\nDo you want to overwrite it? (Y/n)\n" "$hyprspace_path"
  read -r overwrite < /dev/tty
  overwrite=${overwrite:-Y}  # Default to 'Y' if empty
  overwrite=$(echo "$overwrite" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase
  if [ "$overwrite" != "y" ]; then
      printf "Exiting...\n"
      exit 1
  fi
  rm -rf "$hyprspace_path"
fi

# Install required packages
printf "Updating system and installing required packages...\n"
sudo pacman -Syu --noconfirm base-devel git 2>&1 | while IFS= read -r line; do
    if [[ "$line" =~ Total:\ *([0-9]+)/([0-9]+) ]]; then
        printf "\rDownloading: %s/%s packages" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    elif [[ "$line" =~ \(([0-9]+)/([0-9]+)\) ]]; then
        printf "\rInstalling: %s/%s packages" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    fi
done

# Clone the repository
printf "\nCloning the HyprSpace repository...\n"

git clone --progress https://github.com/hurameco/hyprspace.git "$hyprspace_path" 2>&1
# Change directory to the cloned repository
cd "$hyprspace_path" || { printf "Error: Failed to change to %s\n" "$hyprspace_path"; exit 1; }

# Run the installer
printf "Loading utilities...\n"
source "$hyprspace_path/core/utils.sh" || { printf "Error: Failed to source utils.sh\n"; exit 1; }
printf "Running installer...\n"
source "$hyprspace_path/installer.sh" || { printf "Error: Failed to source installer.sh\n"; exit 1; }
