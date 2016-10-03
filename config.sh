#!/bin/bash

# удаляем Apache если он есть
yum remove -y httpd

echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

# включить если установка идет на локальной машине, например в virtualBox
#echo 'nameserver 8.8.8.8' > /etc/resolv.conf

# Отключение Selinux
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Обновление
yum update -y

# Инструменты разработки
yum -y groupinstall 'Development Tools'

# необходимые утилиты для Python pip
yum install -y epel-release libjpeg-devel zlib-devel openssl openssl-devel sqlite-devel net-tools mc wget curl git vim iptables-services
yum update -y
yum install -y htop

systemctl enable iptables
systemctl start iptables

cp /root/centos7/configs/iptables.firewall.rules /etc/iptables.firewall.rules
iptables-restore < /etc/iptables.firewall.rules

/usr/libexec/iptables/iptables.init save
