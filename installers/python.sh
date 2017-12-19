#!/bin/bash

cd /root/

# install python 3.6
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python36u
yum install -y python36u-pip
yum install -y python36u-devel

# создаем пользователя
adduser lamp
cd /home/lamp/

# создаем общую uwsgi
python3.6 -m venv .uwsgi
cd .uwsgi/
source bin/activate
pip install uwsgi
deactivate


# создаем тестовый проект
cd /home/lamp/
mkdir projects
cd projects
python3.6 -m venv wedoca
cd wedoca
source bin/activate
cp /etc/nginx/uwsgi_params ./
pip install --upgrade pip 
pip install django

django-admin.py startproject wedoca
mv wedoca apps
mkdir src
mv apps src/
deactivate
cp /root/centos7_deploy/configs/wedoca.ini ./
cd /home
chown -R lamp:lamp lamp

mkdir -p /etc/uwsgi/sites
cd /etc/uwsgi/sites
ln -s /home/lamp/projects/wedoca/wedoca.ini

cd /var/log/
mkdir uwsgi
chown lamp:lamp uwsgi

cd /run/
mkdir uwsgi
chown lamp:lamp uwsgi

cd /etc/systemd/system
cp /root/centos7_deploy/configs/uwsgi.service ./

# Если что то пошло не так - всегда можно перезапустить systemctl
# systemctl daemon-reload

systemctl start uwsgi
systemctl enable uwsgi
