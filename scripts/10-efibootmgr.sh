#!/bin/bash

logo
notice "Instaling and Configuring GRUB bootloader! [1/1]\n"

# Modify Boot Order
info "Installing packages"
sudo pacman -S grub efibootmgr os-prober --noconfirm >/dev/null 2>&1

# Remove existing GRUB entries from efibootmgr
info "Checking for existing GRUB entries in efibootmgr"
grub_entries=$(efibootmgr | grep -i 'grub' | grep -o 'Boot[0-9A-F]*' | cut -c5-)

if [ -n "$grub_entries" ]; then
    notice "Found existing GRUB entries, removing them"
    for entry_id in $grub_entries; do
        efibootmgr -b "$entry_id" -B >/dev/null 2>&1
        success "Removed GRUB entry: Boot$entry_id"
    done
    success "All existing GRUB entries have been removed"
else
    info "No existing GRUB entries found in efibootmgr"
fi

# Modify /mnt/etc/default/grub to uncomment the last line
info "Checking for /etc/default/grub file"
if [ -f /etc/default/grub ]; then
    info "/etc/default/grub file found"
    last_line=$(tail -n 1 /etc/default/grub)
    # Check if the last line is commented
    if [[ $last_line == \#* ]]; then
        info "Removing comment from last line"
        sed -i "$ s/^#//" /etc/default/grub
    else
        notice "Last line already uncommented"
    fi
else
    error "/etc/default/grub not found"
fi

# Install GRUB to the EFI directory
info "Installing GRUB to EFI directory: /boot"
if ! grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB > /dev/null; then
    error "GRUB installation failed"
fi
success "GRUB installed successfully"

# Generate GRUB configuration file
info "Generating GRUB configuration"
if ! grub-mkconfig -o /boot/grub/grub.cfg; then
    error "Generation of GRUB config failed"
fi

# Check if efibootmgr is installed and configure boot order
info "Configuring GRUB boot order"

# Get the current boot order
current_boot_order=$(efibootmgr | grep '^BootOrder' | cut -d' ' -f2)

# Find the GRUB boot entry ID
grub_boot_id=$(efibootmgr | grep 'GRUB' | grep -o 'Boot[0-9A-F]*' | head -n1 | cut -c5-)

if [ -n "$grub_boot_id" ]; then
    # Set GRUB as the first in the boot order
    new_boot_order="$grub_boot_id,$(echo "$current_boot_order" | sed "s/$grub_boot_id//g" | sed 's/^,\|,,/,/g' | sed 's/,$//')"
    cleaned_boot_order="$(echo "$new_boot_order" | sed "s/$grub_boot_id//g" | sed 's/^,\|,,/,/g' | sed 's/,$//')"

    # Update the boot order
    info "Updating boot order to prioritize GRUB"
    efibootmgr -o "$cleaned_boot_order"
    success "Boot order updated. GRUB is set as the primary boot entry."
else
    error "Failed to find GRUB boot entry not found in efibootmgr."
fi
success "GRUB installation and configuration completed."

sleep 2
