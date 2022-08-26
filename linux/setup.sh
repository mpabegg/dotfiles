#!/bin/bash

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd -m -G wheel -s /bin/bash mpa

passwd mpa

# RUN ON WSL
# >Arch.exe config --default-user {username}

sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Syy archlinux-keyring

sudo pacman -Syyuu

