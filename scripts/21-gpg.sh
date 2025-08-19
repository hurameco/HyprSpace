logo

rnotice "GPG :: [1/2] :: Installing necessary packages for GPG"
sudo pacman -S gnupg --noconfirm >/dev/null 2>&1

if ! command -v gpg >/dev/null 2>&1; then
    warning "gpg command failed or not available. Skipping GPG installation."
    sleep 2
    return 0
fi

# Setup GPG configuration with multiple keyservers for better reliability focusing on privacy
rnotice "GPG :: [2/2] :: Configuring GPG"
sudo mkdir -p /etc/gnupg
sudo cp "$hyprspace_path/default-configs/gpg/dirmngr.conf" /etc/gnupg/
sudo chmod 644 /etc/gnupg/dirmngr.conf
sudo gpgconf --kill dirmngr || true
sudo gpgconf --launch dirmngr || true

success "GPG successfully configured!"
sleep 2
