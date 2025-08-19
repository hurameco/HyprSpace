#!/bin/bash

logo

# Only add Chaotic-AUR if the architecture is x86_64 so ARM users can build the packages
if [[ "$(uname -m)" == "x86_64" ]] && ! command -v yay &>/dev/null; then
    rnotice "AUR :: [1/2] :: Instaling and Configuring Chaotic-AUR! [1/2]"
    # Try installing Chaotic-AUR keyring and mirrorlist
    if ! pacman-key --list-keys 3056513887B78AEB >/dev/null 2>&1 &&
        sudo pacman-key --recv-key 3056513887B78AEB >/dev/null 2>&1 &&
        sudo pacman-key --lsign-key 3056513887B78AEB >/dev/null 2>&1 &&
        sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' >/dev/null 2>&1 &&
        sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' >/dev/null 2>&1; then

        # Add Chaotic-AUR repo to pacman config
        if ! grep -q "chaotic-aur" /etc/pacman.conf; then
            echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' | sudo tee -a /etc/pacman.conf >/dev/null
        fi

        # Install yay directly from Chaotic-AUR
        rnotice "AUR :: [2/2] :: Installing YAY!"
        sudo pacman -Sy --noconfirm --needed yay >/dev/null 2>&1
    fi
fi

# Manually install yay from AUR if not already available
if ! command -v yay &>/dev/null; then
    # Install build tools
    rnotice "AUR :: [2/2] :: Manually installing YAY!"
    sudo pacman -Sy --noconfirm --needed base-devel >/dev/null 2>&1
    cd /tmp
    rm -rf yay-bin
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
    cd -
    rm -rf yay-bin
    cd ~
fi

success "Chaotic-AUR and YAY successfully configured!"
sleep 2
