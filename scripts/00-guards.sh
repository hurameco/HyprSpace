#!/bin/bash

logo

# Must be an Arch distro
rnotice "Guards :: [1/6] :: Checking if running an Arch Linux distro!"
[[ -f /etc/arch-release ]] || error "Not an Arch Linux distro"


# Must not be an Arch derivative distro
rnotice "Guards :: [2/6] :: Checking if running an Arch Linux derivative distro!"
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  [[ -f "$marker" ]] && error "Not a vanilla Arch Linux distro"
done

# Must not be runnig as root
rnotice "Guards :: [3/6] :: Checking if running as root!"
[ "$EUID" -eq 0 ] && error "Do not run this script as root! Please run it as a normal user."

# Must be x86 only to fully work
rnotice "Guards :: [4/6] :: Checking if running on x86_64 architecture!"
[ "$(uname -m)" != "x86_64" ] && error "This script is designed for x86_64 architecture only. Your system is $(uname -m)."

# Must not have Gnome or KDE already install
rnotice "Guards :: [5/6] :: Checking if GNOME or KDE Plasma are installed!"
pacman -Qe gnome-shell &>/dev/null && error "GNOME is already installed. Please remove it before running this script."
pacman -Qe plasma-desktop &>/dev/null && error "KDE Plasma is already installed. Please remove it before running this script."

# Must not have Hyprland already install
rnotice "Guards :: [6/6] :: Checking if Hyprland is already installed!"
pacman -Qe hyprland &>/dev/null && error "Hyprland is already installed. Please remove it before running this script."

rsuccess "System agrees with all requirements!"
sleep 5
