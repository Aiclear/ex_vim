#!/bin/bash

if [ -L ~/.vimrc.local ] || [ -f ~/.vimrc.local ]; then
    rm -rf ~/.vimrc
    rm -rf ~/.vimrc.local
    rm -rf ~/.vimrc.plugins
    rm -rf ~/.vimrc.plugins.local

    cp ./vimrc                ~/.vimrc
    cp ./vimrc.local          ~/.vimrc.local
    cp ./vimrc.plugins        ~/.vimrc.plugins
    cp ./vimrc.plugins.local  ~/.vimrc.plugins.local
fi

if which mkid > /dev/null 2>&1; then
    echo "mkid command is existed."
else
    cd /tmp
    wget http://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz
    tar -xf idutils-4.6.tar.xz
    cd idutils-4.6
    ./configure
    make && make install
    cd ..
    rm -rf idutils-4.6*
fi
