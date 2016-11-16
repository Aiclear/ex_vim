#!/bin/bash

set -e
set -x


os_type=`cat /etc/issue | awk '{print $1}'`

case $os_type in
    [Rr][Ee][Dd]* | \
    [Ff][Ee][Rr]* | \
    [Cc][Ee][Nn]* )
        sudo su
        yum -y install manpages-*
        yum -y install git
        ;;
    *[Uu][Bb][Uu]* )
        sudo su
        apt install manpages-*
        apt install git
        ;;
    *)
        exit
        ;;
esac


echo -n "Now, we will set for git"

read -p "Please input your user.name" u_name
read -p "Please input your user.email" u_email

if [ -n "$u_name" -a -n "$u_email" ]; then
    git config --global user.name "$u_name"
    git config --global user.email "$u_email"
else
    echo "Please input right name and email"
    exit
fi
