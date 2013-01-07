#!/bin/bash

# Dave's 64-bit workstation setup
# Compiled from loads of random scripts over time and space
# 
# Usage: 
# wget -O - https://github.com/dave1010/workstation/setup.sh | sudo sh
#


REPO="https://raw.github.com/dave1010/workstation/master"
GITHUB_USERNAME="dave1010"



test "$(whoami)" != 'root' && echo "Must be ran as root" && exit 1

################################################################################
# SSH
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Share your id_rsa on dropbox, then share the file with a shortlink"
    echo "Enter dropbox link to id_rsa: "
    read -p "http://db.tt/" DB < /dev/tty
    DBURL=$(wget -O - http://db.tt/$DB|grep -o 'https://dl.dropbox[^"]*id_rsa')
    echo "Getting id_rsa from $DBURL"
    wget -O ~/.ssh/id_rsa $DBURL
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    wget -O ~/.ssh/id_rsa.pub $REPO/ssh/id_rsa.pub
fi

if [ ! -f ~/.ssh/config ]; then
    wget -O ~/.ssh/config $REPO/ssh/config
fi

if [ ! -f ~/.ssh/known_hosts ]; then
    wget -O ~/.ssh/known_hosts $REPO/ssh/known_hosts
fi

chmod -R 600 ~/.ssh
chmod 700 ~/.ssh
chown -R $SUDO_USER:$SUDO_USER ~/.ssh




################################################################################
# make a directory to chuck temporary downloads in
if [ ! -d ~/.workstation ]; then
    mkdir ~/.workstation
    chown $SUDO_USER:$SUDO_USER ~/.workstation
fi


cd ~/.workstation

################################################################################

#echo Adding repositories

#add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
#add-apt-repository "deb http://gb.archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
#add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

################################################################################

# INSTALL

if [ 1 -eq 2 ]; then
    apt-get update
fi

which tasksel >    /dev/null || apt-get install -y tasksel

if ! which php > /dev/null; then
    # do this early as it will ask for mysql PW 3 times
    # todo: preset PW: http://serverfault.com/questions/19367/scripted-install-of-mysql-on-ubuntu
    tasksel install lamp-server
else
    echo "LAMP stack already installed"
fi

if ! which sshd > /dev/null; then
    tasksel install openssh-server
else
    echo "ssh server already installed"
fi



which htop >       /dev/null || apt-get install -y htop
which terminator > /dev/null || apt-get install -y terminator
which git >        /dev/null || apt-get install -y git-all
which virtualbox > /dev/null || apt-get install -y virtualbox
which keepass2 >   /dev/null || apt-get install -y keepass2
which gnome-do >   /dev/null || apt-get install -y gnome-do
which nmap >       /dev/null || apt-get install -y nmap
which curl >       /dev/null || apt-get install -y curl
which skype >      /dev/null || apt-get install -y skype
which clamtk >     /dev/null || apt-get install -y clamtk
which remmina >    /dev/null || apt-get install -y remmina


#adobe air
#balsamiq
#screencloud
#gparted


# make sure all packages are up to date
apt-get upgrade -y
apt-get dist-upgrade -y

################################################################################

if ! which java > /dev/null; then
    echo "Installing Oracle Java"
    # license needs confirming
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    apt-get install -y oracle-java7-installer
else
    echo "Java already installed"
fi

# dropbox
if ! which dropbox > /dev/null; then
    echo "Installing Dropbox"
    wget "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.4.0_amd64.deb"
    dpkg -i *dropbox*.deb
else
    echo "Dropbox already installed"
fi
#wget -O - "http://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
#add-apt-repository "deb http://linux.dropbox.com/ubuntu precise main"
#apt-get update
#apt-get install -y nautilus-dropbox


# google-chrome
if ! which google-chrome > /dev/null; then
    echo "Installing Google Chrome"
    #apt-get install libgconf2-4 libnss3-1d libxss1
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome*
    apt-get -f install -y
else
    echo "Google Chrome already installed"
fi


# sublime text
if ! which sublime-text-2 > /dev/null; then
    echo "Installing Sublime Text"
    add-apt-repository -y ppa:webupd8team/sublime-text-2
    apt-get update
    apt-get install -y sublime-text
else
    echo "Sublime Text already installed"
fi



# phpstorm
if ! which /usr/local/phpstorm/bin/phpstorm.sh > /dev/null; then
    echo "Installing PhpStorm"
    PHPSTORM=$(curl http://confluence.jetbrains.net/pages/viewpage.action?pageId=41487696|grep -o 'http[^"]*PhpStorm[^"]*tar.gz'|head -n 1)
    wget $PHPSTORM
    tar xvf PhpStorm*
    rm PhpStorm-*.tar.gz
    mv PhpStorm* /usr/local/phpstorm
else
    echo "PhpStorm already installed"
fi


################################################################################

## PUBLIC SETUP

echo "Setting up Apache"

if [ ! -e /etc/apache2/conf.d/name ]; then
    # stop apache erroring when restarting
    echo "ServerName localhost" >> /etc/apache2/conf.d/name
fi

if [ ! -d /var/www/projects ]; then
    mkdir /var/www/projects
    chmod 777 /var/www/projects
    chown $SUDO_USER:$SUDO_USER /var/www/projects
fi
if [ ! -h ~/projects ]; then
    ln -s /var/www/projects ~/projects
    chown $SUDO_USER:$SUDO_USER ~/projects
fi

# apache mods
a2enmod ssl
a2enmod rewrite
a2enmod headers
a2enmod expires
a2enmod vhost_alias

if [ ! -h /etc/apache2/sites-enabled/projects ]; then
    wget -O /etc/apache2/sites-available/projects $REPO/apache/projects
    a2ensite projects
fi

service apache2 restart

# TODO
# add user to apache group
# setup umask?

echo "Apache setup complete"

################################################################################

echo "Setting up bash stuff"

if [ ! -d ~/bin ]; then
    # bash adds stuff in ~/bin to your path, which is nice
    mkdir ~/bin
fi

if [ ! -d ~/scripts ]; then
    echo "Getting ~/scripts/"
    # this is with write access. could do read only
    sudo -u $SUDO_USER git clone git@github.com:$GITHUB_USERNAME/scripts.git ~/scripts
fi

if [ ! -e ~/.bash_aliases ]; then
    echo "Setting up bash aliases"
    ln -s ~/scripts/aliases.sh ~/.bash_aliases
fi

if ! grep bash_extras ~/.bashrc; then
    # add custom stuff to .bashrc easily
    echo "source ~/scripts/bash_extras" >> ~/.bashrc
fi

if [ ! -d ~/.scm_breeze ]; then
    echo "Setting up scm_breeze"
    sudo -u $SUDO_USER git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
    sudo -u $SUDO_USER ~/.scm_breeze/install.sh
fi

################################################################################

# clean up
apt-get autoclean
apt-get clean


echo "=========================="
echo "Workstation setup complete"

