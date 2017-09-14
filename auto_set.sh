#!/bin/bash

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

# The "mkid" command checked
which mkid 1> /dev/null 2>&1

#安装mkid命令
if [ $? -eq 0 ]; then
    echo "mkid command is existed."
else
    mkid_file=$(ls /tmp/idutils-* 2> /dev/null)
    if [ ! -n "$mkid_file" ]; then
        echo "==> Downloading idutils packages......"
        cd /tmp
        wget http://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz
        tar -xf idutils-4.6.tar.xz
    fi

    # install mkid command
    echo "==> Install idutils packages......"
    if [ -f /tmp/idutils-4.6.tar.xz ]; then
        cd /tmp
        tar -xf idutils-4.6.tar.xz
    fi
    cd /tmp/idutils-4.6
    ./configure 1> /dev/null 2>&1
    make        1> /dev/null 2>&1
    if [ $? -ne 0 ]; then
        cd /tmp/idutils-4.6/lib/
        # 修改文件，不然会编译错误
        sed -i "1030s#^\(_GL_WARN_ON_USE\)#//\1#g" stdio.h
        cd /tmp/idutils-4.6/
    fi

    sudo make && sudo make install
    if [ $? -eq 0 ]; then
        echo "==> Install idutils success......"
    fi
fi
