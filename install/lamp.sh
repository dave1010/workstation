#!/bin/bash

which tasksel >    /dev/null || apt-get install -y tasksel

if ! which php > /dev/null; then
    # do this early as it will ask for mysql PW 3 times
    # todo: preset PW: http://serverfault.com/questions/19367/scripted-install-of-mysql-on-ubuntu
    tasksel install lamp-server
else
    echo "LAMP stack already installed"
fi

