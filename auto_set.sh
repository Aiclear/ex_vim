#!/bin/bash

set -e

#配置为我自己的.vimrc文件
setVim() {
    cd $HOME
    rm -rf .vimrc*

    ln -s $HOME/vimrc/ex_vim/vimrc                 $HOME/.vimrc
    ln -s $HOME/vimrc/ex_vim/vimrc.local           $HOME/.vimrc.local
    ln -s $HOME/vimrc/ex_vim/vimrc.plugins         $HOME/.vimrc.plugins
    ln -s $HOME/vimrc/ex_vim/vimrc.plugins.local   $HOME/.vimrc.plugins.local
}

read -p "Do you want to install a new vim[y|n]" answ
if [ x"$answ" = x"y" ]; then
    cd $HOME
    rm -rf .vimrc
    rm -rf .vimrc.*
    cd /tmp

    if [ ! -d "/tmp/main" -o "`ls /tmp/main/`" == "" ]; then
        git clone https://github.com/exvim/main
    fi
    
    cd /tmp/main
    sh unix/install.sh
    sh unix/replace.sh

    setVim
else
    setVim
fi


which mkid
mkid_file=`ls /tmp | grep 'idutils-*'`

#安装mkid命令
if [ $? -eq 0 ] && [ -n $mkid_file ]; then
    echo "mkid command is existed."
else
    cd /tmp
    wget http://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz
    tar -xf idutils-4.6.tar.xz
fi
