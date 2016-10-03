#!/bin/bash

cd /root/

# install python 3.5
wget http://python.org/ftp/python/3.5.2/Python-3.5.2.tar.xz
tar xf Python-3.5.2.tar.xz
cd Python-3.5.2
./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" --with-zlib-dir=/usr/local/lib
make && make install

# устанавливаем pip
cd ..
wget https://bootstrap.pypa.io/get-pip.py
python3.5 get-pip.py
python get-pip.py


# создаем пользователя
adduser lamp
cd /home/lamp/

# создаем общую uwsgi
mkdir .uwsgi && cd .uwsgi/
pyvenv-3.5 python35
source python35/bin/activate
pip install uwsgi
deactivate


# создаем тестовый проект
cd /home/lamp/
mkdir projects
cd projects
pyvenv-3.5 wedoca
cd wedoca
source bin/activate
cp /etc/nginx/uwsgi_params ./
pip install --upgrade pip 
pip install django

django-admin.py startproject wedoca
deactivate
cd /home
chown -R lamp:lamp lamp

mkdir -p /etc/uwsgi/sites
cd /etc/uwsgi/sites
cp /root/centos7_deploy/configs/wedoca.ini ./

cd /var/log/
mkdir uwsgi
chown lamp:lamp uwsgi

cd /run/
mkdir uwsgi
chown lamp:lamp uwsgi

cd /etc/systemd/system
cp /root/centos7_deploy/configs/uwsgi.service ./

systemctl start uwsgi
systemctl enable uwsgi
