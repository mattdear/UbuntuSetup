#!/bin/sh

# Ensure user is running with superuser privileges
[ $(id -u) != 0 ] && echo 'This script must be run with superuser privileges.' && exit 0

# Sets variables
user=$SUDO_USER
[ -z $user ] && read -p 'What user is running this script? ' user
home=/home/$user

# Custom apt install function
aptinstall(){
  echo "Installing $1 \c"
  apt install -y $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

# Custom snap install function
snapinstall(){
  echo "Installing $1 \c"
  snap install $2 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'
}

# Prompt user to continue function
promptcontinue(){
  echo "$1\c"
  stty -echo
  userinput='this variable needs to contain something otherwise the following loop will immediately pass'
  while [ "$userinput" ]; do
    read userinput
  done
  stty echo
  echo 'Complete'
}

# Script start
clear
echo "############################# Running UbuntuSetup ##############################"

# Update Ubuntu
echo " "
echo "                          Initial Ubuntu configuration                          "
echo "Updating .............................................................. \c"
apt update 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

# Upgrade Ubuntu
echo "Upgrading ............................................................. \c"
apt upgrade -y 1>/dev/null 2>/tmp/stderr && echo 'Complete' || echo -e 'Error: \c' && cat /tmp/stderr | egrep '^E: ' | sed 's/^E: //'

# Configure aliases
echo "Configuring aliases ................................................... \c"
mv .bash_aliases $home
chown $user:$user $home/.bash_aliases
echo "Complete"

# Device specific installs
if [ $(ls '/sys/class/power_supply/' 2>/dev/null) ] ; then
  # Laptop
  echo " "
  echo "                              Laptop snap installs                              "
  snapinstall 'Deja Dup ..................................................' 'deja-dup --classic'
else
  # Desktop
  echo " "
  echo "                              Desktop apt installs                              "
  aptinstall 'Boxes ......................................................' gnome-boxes
fi

# Apt installs
echo " "
echo "                                  Apt installs                                  "
aptinstall 'Vim ........................................................' vim
aptinstall 'Java JDK & JRE .............................................' openjdk-8-jre-headless
aptinstall 'Gnome Tweaks ...............................................' gnome-tweak-tool
aptinstall 'Maven ......................................................' maven
aptinstall 'TexLive ....................................................' texlive
aptinstall 'LaTeXmk ....................................................' latexmk

# Snap installs
echo " "
echo "                                 Snap installs                                  "
snapinstall 'Visual Studio Code .........................................' code --classic
snapinstall 'Postman ....................................................' postman
snapinstall 'DrawIO .....................................................' drawio
snapinstall 'Netbeans ...................................................' 'netbeans --classic'
snapinstall 'Libre Office ...............................................' libreoffice
snapinstall 'Discord ....................................................' discord
snapinstall 'Spotify ....................................................' spotify

# VSCode installs
echo " "
echo "                                VSCode installs                                 "
echo "                      Press [Enter] after each to continue                      "
promptcontinue "Install LaTeX Workshop ................................................ \c"

# Script end
echo " "
echo "############################# UbuntuSetup complete #############################"
