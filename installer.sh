#!/bin/bash

source "$hyprspace_path/scripts/00-guards.sh" || error "Failed to source guards.sh\n"

source "$hyprspace_path/scripts/10-efibootmgr.sh" || error "Failed to source efibootmgr.sh\n"
source "$hyprspace_path/scripts/11-aur.sh" || error "Failed to source aur.sh\n"

source "$hyprspace_path/scripts/20-git.sh" || error "Failed to source git.sh\n"
source "$hyprspace_path/scripts/21-gpg.sh" || error "Failed to source gpg.sh\n"
source "$hyprspace_path/scripts/22-faillock.sh" || error "Failed to source faillock.sh\n"
source "$hyprspace_path/scripts/23-network.sh" || error "Failed to source network.sh\n"
source "$hyprspace_path/scripts/24-power.sh" || error "Failed to source power.sh\n"




source "$hyprspace_path/scripts/29-fix-fkeys.sh" || error "Failed to source fix-fkeys.sh\n"
