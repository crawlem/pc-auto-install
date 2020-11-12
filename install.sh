#!/bin/bash

#
# WSL Ubuntu install script
# -------------------------
#

# Default SSH key
if [[ ! -f ~/.ssh/id_ed25519 ]]
then
    ssh-keygen -t ed25519
fi

# Applications
sudo apt update
sudo apt upgrade --yes
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
sudo apt install --yes $(awk '{print $1'} linux/apps.txt)
sudo apt autoremove

# Dotfiles
rm ~/.gitconfig
ln -sv ~/dotfiles/linux/.gitconfig ~

rm ~/.bashrc
ln -sv ~/dotfiles/linux/.bashrc ~
. ~/.bashrc

rm ~/.tvnamer
ln -sv ~/dotfiles/linux/.tvnamer.json ~

# Jekyll
gem install bundler jekyll
bundle update --bundler

# Confirm completion
figlet "... and we're back!" | lolcat