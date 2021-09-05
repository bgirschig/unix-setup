# linux machine setup

This folder contains config files and setup scripts for common tools (vim, git, bash_profile),
cheatsheets, and other resources for getting up and running on a new unix system

## install
```
apt -qq update && apt -qq install -y curl unzip
bash <(curl -sL https://raw.githubusercontent.com/bgirschig/unix-setup/main/install.sh)
```