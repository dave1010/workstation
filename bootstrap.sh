#!/bin/bash

# Dave's 64-bit workstation setup
# Compiled from loads of random scripts over time and space
# 
# Usage: 
# wget -O - https://github.com/dave1010/workstation/bootstrap.sh | sudo sh
#

REPO="git://github.com/dave1010/workstation.git"

test "$(whoami)" != 'root' && echo "Must be ran as root" && exit 1

which git > /dev/null || apt-get install -y git-all

if [ ! -d ~/.workstation/.git ]; then
    git clone $REPO ~/.workstation
else
    cd ~/.workstation
    git pull
fi

~/.workstation/setup.sh

