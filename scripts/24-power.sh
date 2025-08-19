#!/bin/bash

logo

rnotice "Power :: [1/2] :: Installing Power Profiles Daemon"
sudo pacman -S --noconfirm --needed power-profiles-daemon >/dev/null 2>&1

rnotice "Power :: [2/2] :: Configuring Power Profiles"
if ls /sys/class/power_supply/BAT* &>/dev/null; then
  # This computer runs on a battery
  powerprofilesctl set balanced || true

  # Enable battery monitoring timer for low battery notifications
  systemctl --user enable --now omarchy-battery-monitor.timer || true
else
  # This computer runs on power outlet
  powerprofilesctl set performance || true
fi
