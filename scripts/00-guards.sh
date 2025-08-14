#!/bin/bash

logo
notice "Verifying system requirements! [0/5]\n"

# Must be an Arch distro
[[ -f /etc/arch-release ]] || error "Not an Arch Linux distro"

# Must not be an Arch derivative distro
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  [[ -f "$marker" ]] && error "Not a vanilla Arch Linux distro"
done

# Must not be runnig as root
[ "$EUID" -eq 0 ] && error "Do not run this script as root! Please run it as a normal user."

# Must be x86 only to fully work
[ "$(uname -m)" != "x86_64" ] && error "This script is designed for x86_64 architecture only. Your system is $(uname -m)."

# Must not have Gnome or KDE already install
pacman -Qe gnome-shell &>/dev/null && error "GNOME is already installed. Please remove it before running this script."
pacman -Qe plasma-desktop &>/dev/null && error "KDE Plasma is already installed. Please remove it before running this script."

# Must not have Hyprland already install
pacman -Qe hyprland &>/dev/null && error "Hyprland is already installed. Please remove it before running this script."

success "System agrees with all requirements!"
sleep 2 # Wait for 2 seconds before proceeding
