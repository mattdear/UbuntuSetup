#!/bin/sh
echo "Begining Ubuntu 20.04 setup"
echo "Installing updates..."
sudo apt-get update && sudo apt-get upgrade -y
echo "Setting up aliases..."
mv .bash_aliases ~
echo "Complete"

aptinstall(){
  echo "Installing $1..."
  sudo apt install -y $2 &>/dev/null && echo "Installed $1" || echo "Error installing $1"
}

snapinstall(){
  echo "Installing $1..."
  sudo snap install $2
}

aptinstall Vim vim
aptinstall 'Java JDK & JRE' openjdk-8-jre-headless
aptinstall 'Gnome Tweaks' gnome-tweak-tool
aptinstall Rhythmbox rhythmbox

snapinstall Atom 'atom --classic'
snapinstall Chromium chromium
snapinstall 'Deja Dup Backup Tool' 'deja-dup --classic'
snapinstall Discord discord
snapinstall 'Draw IO' drawio
snapinstall 'Eclipse' 'eclipse --classic'
snapinstall 'Gnome Tweaks' gnome-tweak-tool
snapinstall 'Libre Office' libreoffice
snapinstall Postman postman
snapinstall Spotify spotify
snapinstall 'VLC Player' vlc

echo "Final update check..."
sudo apt-get install && sudo apt-get update -y
sudo snap refresh
read -s -n 1 -p "Ubuntu setup complete"
