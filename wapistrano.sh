# Update the box
apt-get -y install apache2
apt-get install libapache2-mod-php5
apt-get -y install php5-mysql php5-curl
echo "mysql-server-5.5 mysql-server/root_password password vagrant" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password vagrant" | debconf-set-selections
apt-get -y install mysql-server-5.5
apt-get -y install php-pear
apt-get -y install php5
apt-get -y install php5-dev
apt-get -y install php5-intl
apt-get -y install git
apt-get -y install gearman
cd /tmp
git clone https://github.com/nicolasff/phpredis.git
cd phpredis
phpize
./configure
make && make install
echo "extension=redis.so" >> /etc/php5/conf.d/redis.ini
apt-get -y install libgearman-dev
pecl install channel://pecl.php.net/gearman-0.8.3
echo "extension=gearman.so" >> /etc/php5/conf.d/gearman.ini
a2enmod rewrite
sed -i -e "s/\/var\/www/\/var\/www\/wapistrano\/web/g" /etc/apache2/sites-available/default
sed -i -e "s/AllowOverride None/AllowOverride All/g" /etc/apache2/sites-available/default
service apache2 restart
cd /var/www
### WAPISTRANO INSTALL
git clone https://github.com/c2is/wapistrano
cd wapistrano
curl -sS https://getcomposer.org/installer | php
./composer.phar install -n
sed -i -e "s/database_password: null/database_password: vagrant/g" ./app/config/parameters.yml
sed -i -e "s/database_name: symfony/database_name: wapistrano/g" ./app/config/parameters.yml
chmod -R 777 ./app/cache
chmod -R 777 ./app/logs
./app/console doctrine:database:create
./app/console doctrine:schema:update --force
./app/console -n doctrine:fixtures:load
apt-get -y install ruby
gem install capistrano -v 2.15.5
gem install capistrano-ext
apt-get -y install python-setuptools
apt-get -y install redis-server
easy_install redis
easy_install gearman
gem uninstall -I net-ssh
gem install net-ssh -v 2.7.0
useradd wapyd -M -g adm -d /usr/local/wapy/
mkdir /var/log/wapyd/
chgrp adm /var/log/wapyd/
chmod 775 /var/log/wapyd/
cd /usr/local/
git clone https://github.com/c2is/wapy
mkdir /usr/local/wapy/.ssh/
cat <<EOF >> /usr/local/wapy/.ssh/config
Host *
	StrictHostKeyChecking no
EOF
ssh-keygen -f /usr/local/wapy/.ssh/id_rsa -t rsa -N ''
chown -R wapyd:adm /usr/local/wapy/.ssh/
chmod 700 /usr/local/wapy/.ssh/
chown -R wapyd:adm /usr/local/wapy/
mkdir /var/capistrano/
chown -R wapyd:adm /var/capistrano/
cp /usr/local/wapy/wapyd /etc/init.d/
update-rc.d wapyd defaults
cat <<EOF >> /etc/issue
Debian GNU/Linux 7 \n \l

WELCOME TO WAPISTRANO DEMO !

You can connect to this VM by ssh running
#################################
ssh  -p 7222 -l vagrant 127.0.0.1
#################################
User and password are vagrant. To perform root action just use sudo.

To reach Wapistrano, type in your browser
######################
http://localhost:8074/
######################
Admin user and password are admin.

Get the rsa key used by capistrano for cloning projects to deploy
######################
cat /usr/local/wapy/.ssh/id_rsa.pub
######################
EOF

