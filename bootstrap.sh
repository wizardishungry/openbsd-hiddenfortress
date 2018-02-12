#!/bin/sh

. /root/.profile
. /etc/rc.conf

HOSTNAME=$1
CDN_BASE=$2
INSTALL_BASE=$CDN_BASE/`machine -a`/
echo Setting hostname: $HOSTNAME
hostname -s $HOSTNAME
echo $HOSTNAME > /etc/myname

echo "Installing packages…"
pkg_add tor
pkg_add polipo
pkg_add w3m
pkg_add chromium
pkg_add firefox
pkg_add wget

echo "Configuring sshd…"
echo X11Forwarding yes >> /etc/ssh/sshd_config
/etc/rc.d/sshd restart

if [ $( grep -ic "allowaperture" /etc/sysctl.conf ) -gt 0 ]
then
  echo "Looks like we already setup X11…"
else
  # hack for installing X11
  echo "Setup X11… "
  for f in  /vagrant_data/*.tgz ; do tar xzf $f -C /; done
  ldconfig /usr/local/lib /usr/X11R6/lib $shlib_dirs
  echo xenodm_flags=YES >> /etc/rc.conf
  rcctl start xenodm
  sysctl machdep.allowaperture=2 || echo "⚠️ You need to reboot for X11 to work"
  echo machdep.allowaperture=2 >> /etc/sysctl.conf
fi

echo Bootstap done!
