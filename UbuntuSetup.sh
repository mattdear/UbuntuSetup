#!/bin/sh
echo "Begining Ubuntu 20.04 setup"
echo "Installing updates..."
sudo apt-get update && sudo apt-get upgrade -y
echo "Setting up aliases..."
mv .bash_aliases ~
echo "Complete"
echo "Installing Vim..."
sudo apt install -y vim &>/dev/null && echo 'Complete' || echo 'Error'
echo "Installing Java JDK & JRE"
sudo apt install -y openjdk-8-jre-headless &>/dev/null && echo 'Complete' || echo 'Error'
echo "Installing Atom..."
sudo snap install atom --classic
echo "Installing Chromium..."
sudo snap install chromium
echo "Installing Deja Dup Backup Tool..."
sudo snap install deja-dup --classic
echo "Installing Discord..."
sudo snap install discord
echo "Installing Draw IO..."
sudo snap install drawio
echo "Installing Eclipse..."
sudo snap install eclipse --classic
echo "Installing Gnome Tweaks..."
sudo apt install -y gnome-tweak-tool &>/dev/null && echo 'Complete' || echo 'Error'
echo "Installing Libre Office..."
sudo snap install libreoffice
echo "Installing Postman..."
sudo snap install postman
echo "Installing Rhythmbox..."
sudo apt install -y rhythmbox &>/dev/null && echo 'Complete' || echo 'Error'
echo "Installing Spotify..."
sudo snap install spotify
echo "Installing VLC Player..."
sudo snap install vlc
echo "Final update check..."
sudo apt-get install && sudo apt-get update -y
sudo snap refresh
read -s -n 1 -p "Ubuntu setup complete"
