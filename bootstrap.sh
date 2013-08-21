#!/bin/sh
. /root/.profile

HOSTNAME=$1
hostname -s $HOSTNAME > /etc/myname
#export PKG_PATH=ftp://your.ftp.mirror/pub/OpenBSD/5.3/packages/`machine -a`/
pkg_add tor
pkg_add polipo
pkg_add w3m-0.5.3p1
#pkg_add chromium

#configure polipo
echo "socksParentProxy = "localhost:9050"
socksProxyType = socks5" >> /etc/polipo/config

echo "/etc/rc.d/tor start" | tee -a /etc/rc.local | sh
echo "/etc/rc.d/polipo start" | tee -a /etc/rc.local | sh

proxy=http://127.0.0.1:8123

#setup ~vagrant
mkdir ~vagrant/.w3m
echo "http_proxy $proxy
https_proxy $proxy
ftp_proxy $proxy
use_proxy 1" > ~vagrant/.w3m/config
echo "export HTTP_PROXY=$proxy" > ~vagrant/.profile
chown -R vagrant:vagrant ~vagrant

# disable sudo
# mv /etc/sudoers{,.bak}
