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
aptinstall Maven maven
aptinstall 'Hunspell GB' hunspell-en-gb

snapinstall Atom 'atom --classic'
snapinstall Discord discord
snapinstall 'Draw IO' drawio
snapinstall 'Netbeans' 'netbeans --classic'
snapinstall 'Libre Office' libreoffice
snapinstall Postman postman
snapinstall Spotify spotify
snapinstall 'VLC Player' vlc

# Atom Snap install fix - https://stackoverflow.com/questions/62681150/atom-opens-a-new-file-called-atom-disable-shelling-out-for-environment-false

sudo sed -i 's/Exec=env BAMF_DESKTOP_FILE_HINT=\/var\/lib\/snapd\/desktop\/applications\/atom_atom.desktop \/snap\/bin\/atom ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false \/usr\/bin\/atom %F/Exec=env BAMF_DESKTOP_FILE_HINT=\/var\/lib\/snapd\/desktop\/applications\/atom_atom.desktop ATOM_DISABLE_SHELLING_OUT_FOR_ENVIRONMENT=false \/snap\/bin\/atom %F/' /var/lib/snapd/desktop/applications/atom_atom.desktop

echo "UbuntuSetup Complete"
