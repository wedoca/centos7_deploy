#!/bin/bash

# Первоначальная настройка
./config.sh

# Nginx
./installers/nginx.sh

# Python and Uwsgi and Django
./installers/python.sh

# PostgreSql
#./installers/postgresql.sh

# Sphinx
#./installers/sphinx.sh

cd /root/
rm -rf Python-3.5.2*
rm -rf get-pip.py

reboot
