#!/bin/sh
. /root/.profile
. /etc/rc.conf

HOSTNAME=$1
hostname -s $HOSTNAME > /etc/myname
#export PKG_PATH=ftp://your.ftp.mirror/pub/OpenBSD/5.3/packages/`machine -a`/
pkg_add tor
pkg_add polipo
pkg_add w3m-0.5.3p1
#pkg_add chromium

echo "Configuring sshd"
echo X11Forwarding yes >> /etc/ssh/sshd_config
/etc/rc.d/sshd restart

echo Configuring polipo and tor
echo "socksParentProxy = \"localhost:9050\"
socksProxyType = socks5" >> /etc/polipo/config
echo "/etc/rc.d/tor start" | tee -a /etc/rc.local | sh
echo "/etc/rc.d/polipo start" | tee -a /etc/rc.local | sh

echo "Setup user account"
proxy=http://127.0.0.1:8123
mkdir ~vagrant/.w3m
echo "http_proxy $proxy
https_proxy $proxy
ftp_proxy $proxy
use_proxy 1" > ~vagrant/.w3m/config
echo "
export http_proxy=$proxy
export https_proxy=$proxy
export all_proxy=$proxy
export ftp_proxy=$proxy
" > ~vagrant/.profile
chown -R vagrant:vagrant ~vagrant

echo Setting up packet filter rule
echo 'block out on ! lo0 proto { tcp, udp } user vagrant' >> /etc/pf.conf
pfctl -f /etc/pf.conf

# disable sudo
# mv /etc/sudoers{,.bak}

echo Writing MOTD
. ~vagrant/.profile
lynx -width=1000 -dump -nolist http://check.torproject.org/ | sed 's/  */ /g' | egrep '[:alpha:]'| head -n 4 | tail -n 3 >> /etc/motd
echo >> /etc/motd
