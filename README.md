wapistrano_veewee
=================

Veewee server provisioning for Wapistrano demo

#1. Install veewee

See [repository](https://github.com/jedi4ever/veewee) clone method in documentation.

Create an alias in your bashrc:

```
vi ~/bashrc
alias veewee="/opt/local/bin/bundle-1.9 exec veewee"
```

#2 Create the wapistrano_debian definition
```
veewee vbox define wapistrano-debian Debian-7.6.0-amd64-netboot
```

#3 Clone wapistrano_veewee somewhere on your hard disk and link files into the veewee definition's dir
```
git clone git@github.com:c2is/wapistrano_veewee.git
cd veewee/definitions/wapistrano_debian/
ln -s ../../../wapistrano_veewee/definition.rb ./definition.rb
ln -s ../../../wapistrano_veewee/wapistrano.sh ./wapistrano.sh
```

#4 Build the machine
```
veewee vbox build wapistrano-debian
```
Add ```--force``` if it already exists.

#Set additional port forwarding in VirtualBox
Go to configuration->Network->Advanced->Port forwarding and add :
host port: 8074 guest port: 80