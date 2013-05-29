#!/bin/bash
MYSQL_ROOT_PASSWD="sniper"

# Apache & Php
sudo sed -i "s/#LoadModule php5_module/LoadModule php5_module/" /etc/apache2/httpd.conf
sudo cp /etc/php.ini.default /etc/php.ini
# HERE config php as your need 
sudo apachectl start

# Mysql
brew install mysql
mkdir -p ~/Library/LaunchAgents/
sudo cp /usr/local/Cellar/mysql/5.6.10/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
unset TMPDIR
sudo mkdir -p /usr/local/var/mysql
sudo mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
/usr/local/opt/mysql/bin/mysqladmin -u root password ${MYSQL_ROOT_PASSWD}
mysql.server start

# NodeJS
brew install node
curl http://npmjs.org/install.sh | sh
export NODE_PATH="/usr/local/lib/node_modules/"
# install whatever you like
npm install express
