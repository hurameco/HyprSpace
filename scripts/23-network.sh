#!/bin/bash

logo

# Set Cloudflare as primary DNS (with Google as backup)
rnotice "Network :: [1/4] :: Configuring DNS"
sudo cp "$hyprspace_path/default-configs/systemd/resolved.conf" /etc/systemd/

# Solve common flakiness with SSH
rnotice "Network :: [2/4] :: Configuring MTU for SSH"
echo "net.ipv4.tcp_mtu_probing=1" | sudo tee -a /etc/sysctl.d/99-sysctl.conf

# Install iwd explicitly if it wasn't included in archinstall
rnotice "Network :: [3/4] :: Configuring Network Manager (IWD)"
if ! command -v iwctl &>/dev/null; then
    sudo pacman -S --noconfirm --needed iwd >/dev/null 2>&1
    sudo systemctl enable --now iwd.service
    hold
fi

# Prevent systemd-networkd-wait-online timeout on boot
rnotice "Network :: [4/4] :: Disabling systemd-networkd-wait-online"
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service


success "Network successfully configured!"
sleep 2
