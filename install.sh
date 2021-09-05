#!/usr/bin/env bash


################## utils ###########################################################################
export DEBIAN_FRONTEND=noninteractive
root=~/unix-setup
set -e

################## donwload ########################################################################
# Download the latest version of unix-setup
curl -sL https://github.com/bgirschig/unix-setup/archive/refs/heads/main.zip --output /tmp/unix-setup.zip

# extract to home directory
apt -qq install unzip
unzip -q /tmp/unix-setup.zip -d /tmp/unix-setup/
mkdir -p ~/unix-setup && mv /tmp/unix-setup/unix-setup-main/* ~/unix-setup

# cleanup
rm /tmp/unix-setup.zip
rm -rf /tmp/unix-setup

################## UI (Let user select what to install) ############################################
read -p "Install git ? y/n: " installGit
read -p "Install apache ? y/n: " installApache
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
	apt -qq -y install git-all
	echo "  done"
fi

if [[ "$installApache" == "y" ]]; then
	echo "  installing apache" 
	apt -qq -y install apache2
	echo "  done"
fi

if [[ "$installTools" == "y" ]]; then
	echo "  installing various admin and dev tools" 
	apt -qq -y install vim htop lsof byobu systemd lnav direnv curl
	echo "  done"
fi
