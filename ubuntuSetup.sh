#!/bin/sh

# Ensure user is running with superuser privileges
[ $(id -u) != 0 ] && echo 'This script must be run with superuser privileges.' && exit 0

# Sets variables
user=$SUDO_USER
[ -z $user ] && read -p 'What user is running this script? ' user
home=/home/$user

echo "Running UbuntuSetup"

echo -e "Updating... \c"
apt update 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

echo -e "Upgrading... \c"
apt upgrade -y 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

echo -e "Configuring Aliases... \c"
mv .bash_aliases $home
chown $user:$user $home/.bash_aliases
echo "Complete"

aptinstall(){
  echo -e "Installing $1... \c"
  apt install -y $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

snapinstall(){
  echo -e "Installing $1... \c"
  snap install $2 1>/dev/null && echo -e "Complete" || echo -e "Error"
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
snapinstall 'Libre Office' libreoffice
snapinstall Postman postman
snapinstall Spotify spotify
snapinstall 'VLC Player' vlc

echo "UbuntuSetup Complete"
