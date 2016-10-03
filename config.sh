!/bin/bash

# удаляем Apache если он есть
yum remove -y httpd

# включить если установка идет на локальной машине, например в virtualBox
#echo 'nameserver 8.8.8.8' > /etc/resolv.conf

# Отключение Selinux
#setenforce 0
#sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo 'LANG=en_US.utf-8' >> /etc/environment
echo 'LC_ALL=en_US.utf-8' >> /etc/environment

# Обновление
yum update -y

# Инструменты разработки
yum -y groupinstall 'Development Tools'

# необходимые утилиты для Python pip
yum install -y epel-release libjpeg-devel zlib-devel openssl openssl-devel sqlite-devel net-tools mc wget curl git vim iptables-services
yum update -y
yum install -y htop

# подключаем менеджер портов
systemctl enable iptables
systemctl start iptables

iptables-restore < cp /root/centos7_deploy/configs/iptables.firewall.rules
/usr/libexec/iptables/iptables.init save
