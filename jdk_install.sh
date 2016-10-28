#/bin/bash

read -p "Install jdk [y|n]" ans

if [ "$ans"x = "y"x ]; then
#配置安装jdk
    read -p "Please input your jdk file path: " path
    if [ -n "$path" ]; then
        cd /lib
        mkdir java-sun
        tar xf $path/jdk-* -C /lib/java-sun/

        cd /etc/profile.d/
        touch java.sh
        echo "export JAVA_HOME=/lib/java-sun/$(ls /lib/java-sun/ | grep jdk-*)" >> /etc/profile.d/java.sh
        echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile.d/java.sh
        echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile.d/java.sh
        source /etc/profile
    else
        echo "Sorry, I can't go on, if no jdk file"
        exit 1
    fi
else
    echo "OK"
    exit 0
fi
