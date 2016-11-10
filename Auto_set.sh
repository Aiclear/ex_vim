#!/bin/bash

set -e
set -x

#配置为我自己的.vimrc文件
setVim() {
    cd $HOME
    rm -rf .vimrc.*

    ln -s $HOME/vimrc/exvim/vimrc                 $HOME/.vimrc
    ln -s $HOME/vimrc/exvim/vimrc.local           $HOME/.vimrc.local
    ln -s $HOME/vimrc/exvim/vimrc.plugins         $HOME/.vimrc.plugins
    ln -s $HOME/vimrc/exvim/vimrc.plugins.local   $HOME/.vimrc.plugins.local
}

read -p "Do you want to install a new vim[y|n]" answ
if [ x"$answ" = x"y"]; then
    cd /tmp
    git clone https://github.com/exvim/main
    cd /main
    sh unix/install.sh
    sh unix/replace.sh

    setVim
else
    setVim
fi


#安装mkid命令
if which mkid 2>&1 /dev/null; then
    echo "mkid command is existed."
else
    cd /tmp
    wget http://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz
    tar -xf idutils-4.6.tar.xz
fi
