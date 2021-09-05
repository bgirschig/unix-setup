#!/usr/bin/env bash
root=$(dirname "$0")

PHP_VERSION=7.3

export DEBIAN_FRONTEND=noninteractive

read -p "Install git ? y/n: " installGit
read -p "Install apache ? y/n: " installApache
if [[ "$installApache" == "y" ]]; then
	read -p "  install php$PHP_VERSION? y/n: " installPhp
fi
read -p "Install admin and dev tools vim,htop,etc.. ? y/n: " installTools

echo "updating package list and system"
# update package list & update the installed packages
apt update
apt upgrade

# install custom commands
cp $root/commands/* /usr/local/bin

# Put config files in their place
cp $root/configs/vimrc ~/.vimrc
cp $root/configs/bashrc ~/.bashrc
cp $root/configs/gitconfig ~/.gitconfig

if [[ "$installGit" == "y" ]]; then
	echo "  installing git"    
	apt install -qy git-all
	echo "  done"
fi

if [[ "$installApache" == "y" ]]; then
	echo "  installing apache" 
	apt install -qy apache2
	echo "  done. To enable/disable a site, use the a2ensite/a2dissite command"
fi

if [[ "$installPhp" == "y" ]]; then
	echo "  installing php$PHP" 
	apt install -qy \
		php$PHP_VERSION \
		php$PHP_VERSION-mbstring \
		php$PHP_VERSION-curl \
	echo "  done"
fi

if [[ "$installTools" == "y" ]]; then
	echo "  installing various admin and dev tools" 
	apt install -qy \
		vim \
		htop \
		lsof \
		byobu \
		systemd \
		lnav \
		direnv \
		curl
	pip install \
		pillow \
		pyplot
	echo "  done"
fi