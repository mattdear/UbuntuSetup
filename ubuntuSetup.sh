#!/bin/sh

# Ensure user is running with superuser privileges
[ $(id -u) != 0 ] && echo 'This script must be run with superuser privileges.' && exit 0

# Sets variables
user=$SUDO_USER
[ -z $user ] && read -p 'What user is running this script? ' user
home=/home/$user

# Script start
echo "Running UbuntuSetup"

# Custom apt install function
aptinstall(){
  echo -e "Installing $1... \c"
  apt install -y $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

# Custom snap install function
snapinstall(){
  echo -e "Installing $1... \c"
  snap install $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

# Custom apm install function
apminstall(){
  echo -e "Installing $1... \c"
  apm install $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

# Setting up Atom installer
echo -e "Retrieving Atom GPG Key"
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
echo -e "Adding Atom To Apt Sources"
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
#sudo apt-get update

# Installing cURL
aptinstall Curl curl

# Setting up Spotify installer
echo -e "Retrieving Spotify GPG Key"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
echo -e "Adding Spotify To Apt Sources"
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
#sudo apt-get update

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

if [ $(ls '/sys/class/power_supply/' 2>/dev/null) ] ; then
  # LAPTOP
  snapinstall Deja Dup 'deja-dup --classic'
else
  # DESKTOP
  aptinstall Boxes gnome-boxes
fi

# Apt installs
aptinstall Vim vim
aptinstall 'Java JDK & JRE' openjdk-8-jre-headless
aptinstall 'Gnome Tweaks' gnome-tweak-tool
aptinstall Maven maven
aptinstall 'Hunspell en-GB' hunspell-en-gb
aptinstall Atom atom
aptinstall Spotify spotify-client

# Snap installs
snapinstall Postman postman
snapinstall DrawIO drawio
snapinstall Netbeans 'netbeans --classic'
snapinstall 'Libre Office' libreoffice
snapinstall Discord discord

# Atom package installs
apminstall Latex latex
apminstall Language-Latex language-latex

# Manual installs
echo "Manual installs"
read -p "TexLive press [Enter] once complete..."

# Script end
echo "UbuntuSetup Complete"
