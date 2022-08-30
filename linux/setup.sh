#!/bin/bash
set -e

DOTFILES_DIR="$HOME/.dotfiles"

function init_packman(){
	sudo pacman-key --init
	sudo pacman-key --populate

	sudo pacman -Syy archlinux-keyring
	sudo pacman -Syyuu git openssh
}

function init_git(){
	cd $HOME
	cp -r /mnt/d/ssh/ "$HOME/.ssh/"
	git clone --recurse-submodule git@github.com:mpabegg/dotfiles.git $DOTFILES_DIR
}

function change_shell(){
		echo "Changing shell, it will ask for sudo password."
		echo "> sudo echo \`which zsh\` >> /etc/shells"
		echo "> chsh -s \`which zsh\`"
}

if [[ ! -f "/home/mpa/setup.sh" ]];then
	echo "Set sudo password:"
	passwd

	echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
	useradd -m -G wheel -s /bin/bash mpa

	echo "Set password for mpa:"
	passwd mpa

	echo "Cloning script into /home/mpa/setup.sh"
        curl -s -o "/home/mpa/setup.sh" "https://raw.githubusercontent.com/mpabegg/dotfiles/master/linux/setup.sh"
	chmod +x "/home/mpa/setup.sh"

	echo "=> Now go back to Windows Power Shell and do:"
	echo "> {PATH}\Arch.exe config --default-user mpa"
	echo "> wsl --set-default Arch"
	echo "=> Then run ~/setup.sh"

else
	if [[ `whoami` == mpa ]];then
		init_packman
		init_git
		sh $DOTFILES_DIR/linux/paru.sh
		sh $DOTFILES_DIR/linux/packages.sh
		change_shell
		cd $DOTFILES_DIR
		stow git zsh
	fi
fi




