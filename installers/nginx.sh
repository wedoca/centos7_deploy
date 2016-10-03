#!/bin/bash

# добавляем репозиторий
echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
' > /etc/yum.repos.d/nginx.repo

yum install -y nginx
systemctl start nginx
systemctl enable nginx

cd /etc/nginx
mkdir sites-available sites-enabled
mv nginx.conf nginx.conf.back
cp /root/centos7_deploy/configs/nginx.conf ./

cd sites-available/
cp /root/centos7_deploy/configs/wedoca.conf ./
cd ../sites-enabled/
ln -s ../sites-available/wedoca.conf
