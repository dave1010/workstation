#!/bin/bash

if ! which php > /dev/null; then
    # do this early as it will ask for mysql PW 3 times
    # todo: preset PW: http://serverfault.com/questions/19367/scripted-install-of-mysql-on-ubuntu
    tasksel install lamp-server
else
    echo "LAMP stack already installed"
fi

which pear > /dev/null || apt-get install -y php-pear
pear info XML_RPC2 > /dev/null || pear install XML_RPC2

pear config-set auto_discover 1
which phpunit > /dev/null || pear install pear.phpunit.de/PHPUnit
which phpunit-skelgen > /dev/null || pear install phpunit/PHPUnit_SkeletonGenerator
