#!/usr/bin/env bash
current_dir=`pwd`

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password redvsblue'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password redvsblue'

sudo sed -i.bak 's/bind-address/#bind-address/g' /etc/mysql/my.cnf
sudo service mysql restart

sudo apt-get install -y mysql-server mysql-client
mysql -uroot -predvsblue -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'redvsblue' WITH GRANT OPTION"

