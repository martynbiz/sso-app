#!/usr/bin/env bash

sudo apt-get update

# ========================================
# install apache

sudo apt-get install -y apache2


# ========================================
# install mysql

MYSQL_ROOT_PASSWORD="vagrant1"

# prevent the prompt screen from showing
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

# install mysql server
sudo apt-get install -y mysql-server


# ========================================
# install php

sudo apt-get install -y php libapache2-mod-php php-mcrypt php-mysql php-curl php-mbstring php-xml


# ========================================
# setup virtual host

PROJECT_ROOT = /var/www/o-eco

# create apache config
sudo bash -c 'cat <<EOT >>/etc/apache2/sites-available/o-eco.conf
<VirtualHost *:80>
    ServerName o-eco.vagrant
    DocumentRoot /var/www/o-eco/website/public

    <Directory var/www/o-eco/website/public/>
        Options FollowSymLinks
        AllowOverride All
    </Directory>

    # Logging
    ErrorLog /var/log/apache2/o-eco-error.log
    LogLevel notice
    CustomLog /var/log/apache2/o-eco-access.log combined
</VirtualHost>
EOT
'

sudo a2ensite o-eco.conf
sudo service apache2 reload

# clear cache and re-generate key for this box
cd /var/www/o-eco/website
php artisan key:generate
php artisan config:clear
