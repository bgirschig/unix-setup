#!/usr/bin/env bash

################## config ##########################################################################
PHP_VERSION=7.3

################## utils ###########################################################################
export DEBIAN_FRONTEND=noninteractive
root=~/unix-setup
set -e

################## donwload ########################################################################
# Download the latest version of unix-setup
curl -sL https://github.com/bgirschig/unix-setup/archive/refs/heads/main.zip --output /tmp/unix-setup.zip

# extract to home directory
unzip -q /tmp/unix-setup.zip -d /tmp/unix-setup/
mkdir -p ~/unix-setup && mv /tmp/unix-setup/unix-setup-main/* ~/unix-setup

# cleanup
rm /tmp/unix-setup.zip
rm -rf /tmp/unix-setup

################## UI (Let user select what to install) ############################################
read -p "Install git ? y/n: " installGit
read -p "Install apache ? y/n: " installApache
if [[ "$installApache" == "y" ]]; then
	read -p "  install php$PHP_VERSION? y/n: " installPhp
fi
read -p "Install admin and dev tools vim,htop,etc.. ? y/n: " installTools

################## Actual setup ####################################################################

# update package list & update the installed packages
apt -qq update
apt -qq upgrade

# install custom commands
echo "  setting up custom commands"
cp $root/commands/* /usr/local/bin

# Put config files in their place
echo "  setting up config files"
cp $root/configs/vimrc ~/.vimrc
cp $root/configs/bashrc ~/.bashrc
cp $root/configs/gitconfig ~/.gitconfig

if [[ "$installGit" == "y" ]]; then
	echo "  installing git"    
	apt -qq install -y git-all
	echo "  done"
fi

if [[ "$installApache" == "y" ]]; then
	echo "  installing apache" 
	apt -qq install -y apache2
	echo "  done. To enable/disable a site, use the a2ensite/a2dissite command"
fi

if [[ "$installPhp" == "y" ]]; then
	echo "  installing php$PHP" 
	apt -qq install -y \
		php$PHP_VERSION \
		php$PHP_VERSION-mbstring \
		php$PHP_VERSION-curl \
	echo "  done"
fi

if [[ "$installTools" == "y" ]]; then
	echo "  installing various admin and dev tools" 
	apt -qq install -qy \
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
