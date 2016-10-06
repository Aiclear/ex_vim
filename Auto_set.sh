#!/bin/bash

ln -s ./.vimrc                ~/.vimrc
ln -s ./.vimrc.local          ~/.vimrc.local
ln -s ./.vimrc.plugins        ~/.vimrc.plugins
ln -s ./.vimrc.plugins.local  ~/.vimrc.plugins.local

mkid
if [ $? != 0 ]; then
    cd /tmp
    wget http://jaist.dl.sourceforge.net/project/gnuwin32/id-utils/4.0-2/id-utils-4.0-2-src.zip
    gunzip id-utils-4.0-2-src.zip
    cd id-utils-4.0-2-src
    ./configure
    make && make install
    cd ..
    rm -rf id-utils-4.0-2-src*
fi
