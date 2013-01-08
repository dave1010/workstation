#!/bin/bash


if ! which sshd > /dev/null; then
    tasksel install openssh-server
else
    echo "ssh server already installed"
fi

