#!/bin/sh
echo "Running ubuntuSetup"

echo "Updateing Ubuntu..."
sudo apt update &>/dev/null && echo "Complete" || echo "Error"
sudo apt upgrade -y &>/dev/null && echo "Complete" || echo "Error"

echo "Configuring Aliases..."
mv .bash_aliases ~
echo "Complete"

aptinstall(){
  echo "Installing $1..."
  sudo apt install -y $2 &>/dev/null && echo "Complete" || echo "Error"
}

snapinstall(){
  echo "Installing $1..."
  sudo snap install $2 &>/dev/null && echo "Complete" || echo "Error"
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

read -s -n 1 -p "Ubuntu setup complete"
