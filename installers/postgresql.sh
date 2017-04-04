#!/bin/bash

# Предварительные настройки для использования более свежей версии
yum install http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-redhat95-9.5-2.noarch.rpm

# Установка
yum install -y postgresql95-server postgresql95-devel postgresql95-contrib
/usr/pgsql-9.5/bin/postgresql95-setup initdb

# Запуск службы
systemctl start postgresql-9.5.service

# Установка пароля для postgres
#echo 'Установка пароля СУБД PostgreSql для пользователя postgres'
#sudo -u postgres psql -c '\password postgres '

# Настройка авторизации
#sed -i 's/host    all             all             127.0.0.1\/32            ident/host    all             all             0.0.0.0\/0            password/g' /var/lib/pgsql/9.5/data/pg_hba.conf
#sed -i 's/host    all             all             ::1\/128                 ident/host    all             all             ::1\/128              password/g' /var/lib/pgsql/9.5/data/pg_hba.conf

# Удаленный доступ
#sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/9.4/data/postgresql.conf

systemctl restart postgresql-9.5.service
systemctl enable postgresql-9.5.service
