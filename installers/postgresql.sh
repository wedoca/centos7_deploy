#!/bin/bash

# Установка
yum install -y postgresql-server postgresql-devel postgresql-contrib
postgresql-setup initdb

# Запуск службы
systemctl start postgresql

# Установка пароля для postgres
echo 'Установка пароля СУБД PostgreSql для пользователя postgres'
sudo -u postgres psql -c '\password postgres '

# Настройка авторизации
sed -i 's/host    all             all             127.0.0.1\/32            ident/host    all             all             0.0.0.0\/0            password/g' /var/lib/pgsql/data/pg_hba.conf
sed -i 's/host    all             all             ::1\/128                 ident/host    all             all             ::1\/128              password/g' /var/lib/pgsql/data/pg_hba.conf

# Удаленный доступ
#sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/9.4/data/postgresql.conf

systemctl restart postgresql
systemctl enable postgresql
