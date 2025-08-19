#!/bin/bash

logo

# Modify Boot Order
rnotice "Boot :: [1/6] :: Installing necessary packages for GRUB"
sudo pacman -S grub efibootmgr os-prober --noconfirm >/dev/null 2>&1

if ! command -v efibootmgr >/dev/null 2>&1 || ! efibootmgr >/dev/null 2>&1; then
    warning "efibootmgr command failed or not available. Skipping GRUB installation."
    sleep 2
    return 0
fi

# Remove existing GRUB entries from efibootmgr
hold
rnotice "Boot :: [2/6] :: Checking for existing GRUB entries in efibootmgr"
hold
grub_entries=$(efibootmgr | grep -i 'grub' | grep -o 'Boot[0-9A-F]*' | cut -c5-)
if [ -n "$grub_entries" ]; then
    for entry_id in $grub_entries; do
        efibootmgr -b "$entry_id" -B >/dev/null 2>&1
    done
fi

hold

# Modify /mnt/etc/default/grub to uncomment the last line
rnotice "Boot :: [3/6] :: Modifying /etc/default/grub to uncomment the last line"
if [ -f /etc/default/grub ]; then
    last_line=$(tail -n 1 /etc/default/grub)
    # Check if the last line is commented
    if [[ $last_line == \#* ]]; then
        sed -i "$ s/^#//" /etc/default/grub
    fi
else
    error "/etc/default/grub not found"
fi

# Install GRUB to the EFI directory
rnotice "Boot :: [4/6] :: Installing GRUB to EFI directory: /boot"
if ! grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB > /dev/null 2>&1; then
    error "Failed to install GRUB to EFI directory"
fi

# Generate GRUB configuration file
rnotice "Boot :: [5/6] :: Generating GRUB configuration"
if ! grub-mkconfig -o /boot/grub/grub.cfg; then
    error "Generation of GRUB config failed"
fi

# Check if efibootmgr is installed and configure boot order
rnotice "Boot :: [6/6] :: Configuring GRUB boot order"
current_boot_order=$(efibootmgr | grep '^BootOrder' | cut -d' ' -f2)
grub_boot_id=$(efibootmgr | grep 'GRUB' | grep -o 'Boot[0-9A-F]*' | head -n1 | cut -c5-)
if [ -n "$grub_boot_id" ]; then
    # Set GRUB as the first in the boot order
    new_boot_order="$grub_boot_id,$(echo "$current_boot_order" | sed "s/$grub_boot_id//g" | sed 's/^,\|,,/,/g' | sed 's/,$//')"
    cleaned_boot_order="$(echo "$new_boot_order" | sed "s/$grub_boot_id//g" | sed 's/^,\|,,/,/g' | sed 's/,$//')"
    efibootmgr -o "$cleaned_boot_order"
fi

success "GRUB successfully installed and configured!"
sleep 2
