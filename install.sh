#!/bin/bash

# Первоначальная настройка
./config.sh

# Nginx
./installers/nginx.sh

# Python and Uwsgi and Django
./installers/python.sh

# PostgreSql
./installers/postgresql.sh

# Sphinx
./installers/sphinx.sh

cd /root/
rm -rf Python-3.4.4*
rm -rf get-pip.py
rm -rf CentOS-Base.repo.diff

reboot
