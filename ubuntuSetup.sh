#!/bin/sh

# Ensure user is running with superuser privileges
[ $(id -u) != 0 ] && echo 'This script must be run with superuser privileges.' && exit 0

# Sets variables
user=$SUDO_USER
[ -z $user ] && read -p 'What user is running this script? ' user
home=/home/$user

# Script start
echo "Running UbuntuSetup"

# Setting up Atom installer
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get update

# Setting up Spotify installer
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update

# Update start
echo -e "Updating... \c"
apt update 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

# Upgrade start
echo -e "Upgrading... \c"
apt upgrade -y 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

# Configure aliases
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

# Machine type specific installs
if [ ! $(ls /sys/class/power_supply/*) ] ; then
  # Desktop	
  aptinstall Boxes gnome-boxes
else	
  # Laptop
  snapinstall Deja Dup 'deja-dup --classic'
fi

# Apt installs
aptinstall Vim vim
aptinstall 'Java JDK & JRE' openjdk-8-jre-headless
aptinstall 'Gnome Tweaks' gnome-tweak-tool
aptinstall Maven maven
aptinstall 'Hunspell GB' hunspell-en-gb
aptinstall Atom Atom
aptinstall Spotify spotify-client

# Snap installs
snapinstall Postman postman
snapinstall DrawIO drawio
snapinstall Netbeans 'netbeans --classic'

# Manual installs
echo "Manual installs"
read -s -n 1 -p "Discord press [Enter] once complete..."
read -s -n 1 -p "Libre Office press [Enter] once complete..."

# Script end
echo "UbuntuSetup Complete"
