#!/bin/bash

if [[ ! -f /etc/modprobe.d/hid_apple.conf ]]; then
    logo
    rnotice "F Keys :: [1/1] :: Fixing F Keys for Apple Keyboards"
    echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf
    success "F Keys successfully fixed for Apple Keyboards!"

  # Rely on install/login.sh to do the rebuild
  # sudo mkinitcpio -P
fi
