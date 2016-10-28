#!/bin/bash

#vim 配置安装
cd /tmp
git clone https://github.com/exvim/main
cd /main
sh unix/install.sh
sh unix/replace.sh

cd $HOME
rm -rf .vimrc.*

ln -s /root/vimrc/exvim/vimrc                 /root/.vimrc
ln -s /root/vimrc/exvim/vimrc.local           /root/.vimrc.local
ln -s /root/vimrc/exvim/vimrc.plugins         /root/.vimrc.plugins
ln -s /root/vimrc/exvim/vimrc.plugins.local   /root/.vimrc.plugins.local

if which mkid 2>&1 /dev/null; then
    echo "mkid command is existed."
else
    cd /tmp
    wget http://ftp.gnu.org/gnu/idutils/idutils-4.6.tar.xz
    tar -xf idutils-4.6.tar.xz
fi

read -p "Install jdk [y|n]" ans

if [ "$ans"x = "y"x ]; then
#配置安装jdk
    cd /lib
    mkdir java-sun
    tar xf /home/xinzhe/Downloads/jdk-* -C /lib/java-sun/

    cd /etc/profile.d/
    touch java.sh
    echo "export JAVA_HOME=/lib/java-sun/$(ls /lib/java-sun/ | grep jdk-*)" >> /etc/profile.d/java.sh
    echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile.d/java.sh
    echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile.d/java.sh
else
    echo "OK"
    exit 0
fi
