#!/bin/bash

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

cp -nv $WS/ssh/* ~/.ssh/


chmod -R 600 ~/.ssh
chmod 700 ~/.ssh
chown -R $SUDO_USER:$SUDO_USER ~/.ssh

