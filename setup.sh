#!/bin/bash

# Dave's 64-bit workstation setup
# Compiled from loads of random scripts over time and space

test "$(whoami)" != 'root' && echo "Must be ran as root" && exit 1

WS=`dirname $0`
source $WS/config.sh


source $WS/ssh.sh
source $WS/repos.sh


################################################################################

# INSTALL

if [ 1 -eq 2 ]; then
    apt-get update
fi

which tasksel > /dev/null || apt-get install -y tasksel

source $WS/install/lamp.sh
source $WS/install/ssh.sh
source $WS/install/apt-get.sh

#REMOVE
which abiword > /dev/null && apt-get remove -y abiword


# make sure all packages are up to date
apt-get upgrade -y
apt-get dist-upgrade -y


source $WS/install/java.sh
source $WS/install/dropbox.sh
source $WS/install/google-chrome.sh
source $WS/install/sublime-text.sh
source $WS/install/phpstorm.sh
#source $WS/install/balsamiq.sh


## PUBLIC SETUP

source $WS/apache.sh
source $WS/bash.sh

# clean up
apt-get autoclean
apt-get clean

echo
echo "=========================="
echo "Workstation setup complete"

