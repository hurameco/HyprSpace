#!/bin/bash

logo
rnotice "Configuring git [1/1]"

printf "\n\nEnter your git username:\n> "
read -r git_username < /dev/tty
printf "\nEnter your git email:\n> "
read -r git_email < /dev/tty

git config --global user.name "$git_username"
git config --global user.email "$git_email"

success "Git successfully configured!"
sleep 2
