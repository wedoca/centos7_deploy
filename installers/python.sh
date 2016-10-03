#!/bin/bash

cd /root/

# install python 3.4
wget http://python.org/ftp/python/3.4.4/Python-3.4.4.tar.xz
tar xf Python-3.4.4.tar.xz
cd Python-3.4.4
./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" --with-zlib-dir=/usr/local/lib
make && make install

# устанавливаем pip
cd ..
wget https://bootstrap.pypa.io/get-pip.py
python3.4 get-pip.py
python get-pip.py


# создаем пользователя
adduser lamp
cd /home/lamp/

# создаем общую uwsgi
mkdir .uwsgi && cd .uwsgi/
pyvenv-3.4 python34
source python34/bin/activate
pip install uwsgi
deactivate


# создаем тестовый проект
cd /home/lamp/
mkdir projects && cd projects
pyvenv-3.4 onlyspin
cd onlyspin
source bin/activate
cp /etc/nginx/uwsgi_params ./
pip install --upgrade pip
pip install django

# копируем config uwsgi
cp /root/centos7/configs/onlyspin.ini ./
django-admin.py startproject onlyspin
deactivate
cd ..
chown -R lamp:lamp onlyspin

mkdir -p /etc/uwsgi/python34/vassals
cd /etc/uwsgi/python34/vassals
ln -s /home/lamp/projects/onlyspin/onlyspin.ini

cd /var/log/
mkdir uwsgi
chown lamp:lamp uwsgi

echo '
/home/lamp/.uwsgi/python34/bin/uwsgi --emperor /etc/uwsgi/python34/vassals/ --uid lamp --gid lamp
' >> /etc/rc.local

chmod a+x /etc/rc.local

echo '' >> /etc/rc.local

#это не срабатывает
#echo 'systemctl stop iptables' >> /etc/rc.local
