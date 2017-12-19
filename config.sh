#!/bin/bash

# удаляем Apache если он есть
yum remove -y httpd

# включить если установка идет на локальной машине, например в virtualBox
#echo 'nameserver 8.8.8.8' > /etc/resolv.conf

# Отключение Selinux
#setenforce 0
#sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
rpm -ivh epel-release-7-11.noarch.rpm

# Обновление
yum update -y

# Инструменты разработки
yum install -y yum-utils
yum -y groupinstall development

# необходимые утилиты для Python pip
yum install -y redis libjpeg-devel zlib-devel openssl openssl-devel sqlite-devel net-tools mc wget curl git vim iptables-services policycoreutils htop tmux

# установка redis как сервиса и его запуск
systemctl start redis.service
systemctl status redis.service
systemctl enable redis

# подключаем менеджер портов
systemctl enable iptables
systemctl start iptables

iptables-restore < /root/centos7_deploy/configs/iptables.firewall.rules
/usr/libexec/iptables/iptables.init save
