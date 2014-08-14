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

#Export the VM
Name: wapistrano-debian
Product: Wapistrano
Product Url: https://github.com/c2is/wapistrano
Vendor: c2is
Vendor url: http://www.c2is.fr
Version: alpha
Description: A virtual debian server to get wapistrano ready to use.
Licence: This product comes under the MIT License (MIT)

Copyright (c) 2014 C2IS

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.