#!/bin/bash

function upgradingPhp {
    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install libapache2-mod-php7.0
    sudo a2dismod php5
    sudo a2enmod php7.0
    sudo apt-get install php7.0-dom
    sudo apt-get install php7.0-mbstring
    sudo apt-get install php7.0-zip
    
    sudo apt-get install php7.0-mysql
    sudo apt-get install php7.0-sqlite   
}
upgradingPhp

function craftProject {
    rm README.md php.ini hello-world.php
    sudo composer global require 'laravel/installer'
    export PATH=~/.composer/vendor/bin:$PATH
    laravel new laravel
    mv laravel/* ./
    rm -rf laravel
}
craftProject

function editFile {
    sudo sh -c 'echo "<VirtualHost *:8080>
    DocumentRoot /home/ubuntu/workspace/public
    ServerName https://\${C9_HOSTNAME}:443
    LogLevel info
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    <Directory /home/ubuntu/workspace>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
ServerName https://\${C9_HOSTNAME}
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > /etc/apache2/sites-enabled/001-cloud9.conf'
}
editFile

function mySQL {
    mysql-ctl cli
    phpmyadmin-ctl install
}
mySQL
