#!/bin/bash


if ! command -v tzupdate &>/dev/null; then
    logo
    rnotice "Timezones :: [1/2] :: Installing tzupdate"
    sudo pacman -S --noconfirm --needed tzupdate >/dev/null 2>&1
    sudo tee /etc/sudoers.d/omarchy-tzupdate >/dev/null <<EOF
%wheel ALL=(root) NOPASSWD: /usr/bin/tzupdate, /usr/bin/timedatectl
EOF
    sudo chmod 0440 /etc/sudoers.d/omarchy-tzupdate
fi
