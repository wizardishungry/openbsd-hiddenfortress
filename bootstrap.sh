#!/bin/sh
. /root/.profile
. /etc/rc.conf

HOSTNAME=$1
echo Setting hostname: $HOSTNAME
hostname -s $HOSTNAME
echo $HOSTNAME > /etc/myname

# Temporary hack for installing X11 while I wait for new packer img
echo Attempting to mount OpenBSD iso\; this is a hack
mkdir /mnt/cd
mount /dev/cd1a /mnt/cd/
echo -n "Untar X11... "
for f in  /mnt/cd/5.3/amd64/x*.tgz ; do tar xzf $f -C /; done
ldconfig /usr/local/lib /usr/X11R6/lib $shlib_dirs
echo done!

echo "Installing packages"
export PKG_PATH=http://ftp3.usa.openbsd.org/pub/OpenBSD/5.3/packages/`machine -a`/
pkg_add polipo
pkg_add w3m-0.5.3p1
pkg_add chromium-24.0.1312.68
pkg_add firefox

echo "Configuring sshd"
echo X11Forwarding yes >> /etc/ssh/sshd_config
/etc/rc.d/sshd restart

echo Configuring polipo
echo "socksParentProxy = \"localhost:9050\"
socksProxyType = socks5" >> /etc/polipo/config
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
export PKG_PATH=$PKG_PATH
" > ~vagrant/.profile
chown -R vagrant:vagrant ~vagrant

echo Setting up packet filter rule
echo 'block out on ! lo0 proto { tcp, udp } user vagrant' >> /etc/pf.conf
echo 'pass out on ! lo0 proto udp from any to any port 53' >> /etc/pf.conf
echo 'pass out on ! lo0 proto tcp from any to any port 22' >> /etc/pf.conf

pfctl -f /etc/pf.conf

# disable sudo
# mv /etc/sudoers{,.bak}
