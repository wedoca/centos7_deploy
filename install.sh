#!/bin/bash

# Первоначальная настройка
chmod u+x ./config.sh
./config.sh

# Nginx
chmod u+x ./installers/nginx.sh
./installers/nginx.sh

# Python and Uwsgi and Django
chmod u+x ./installers/python.sh
./installers/python.sh

# PostgreSql
#chmod u+x ./installers/postgresql.sh
#./installers/postgresql.sh

# Sphinx
#chmod u+x ./installers/sphinx.sh
#./installers/sphinx.sh

cd /root/
rm -rf Python-3.5.2*
rm -rf get-pip.py

reboot
