#!/bin/sh

. /root/.profile
. /etc/rc.conf

# TORRC_APPEND: put servers for bootstrapping tor here, etc.
# TORRC_APPEND="bridge   187.151.51.71:443 26f6039b96e9a156520335327a8ec8dbcef5620f
# bridge   74.78.122.175:443 f832e688f1e281696a71cb80bffbbf20bdfb4141
# bridge   23.23.17.195:443 9284072d42950fe9b9c749491fcf6793940816ef"
TORRC_APPEND=""

HOSTNAME=$1
CDN_BASE=$2
INSTALL_BASE=$CDN_BASE/`machine -a`/
echo Setting hostname: $HOSTNAME
hostname -s $HOSTNAME
echo $HOSTNAME > /etc/myname

if [ $( grep -ic "allowaperture" /etc/sysctl.conf ) -gt 0 ]
then
  echo "Looks like we already setup X11…"
else
  # hack for installing X11
  echo "Setup X11… "
  for f in  /vagrant_data/*.tgz ; do tar xzf $f -C /; done
  ldconfig /usr/local/lib /usr/X11R6/lib $shlib_dirs
  echo xenodm_flags=YES >> /etc/rc.conf.local
  rcctl start xenodm
  sysctl machdep.allowaperture=2 || echo "⚠️ You need to reboot for X11 to work!"
  echo machdep.allowaperture=2 >> /etc/sysctl.conf
fi

PKG_SCRIPTS="tor polipo"
echo "Installing default packages…"
export PKG_PATH=$CDN_BASE/packages/amd64/
pkg_add -V tor polipo w3m chromium firefox wget lynx

echo "Configuring sshd…"
echo X11Forwarding yes >> /etc/ssh/sshd_config
echo PasswordAuthentication no >> /etc/ssh/sshd_config

echo Configuring polipo and tor…
echo "$TORRC_APPEND" >> /etc/tor/torrc
echo "socksParentProxy = \"localhost:9050\"" >> /etc/polipo/config
echo "socksProxyType = socks5" >> /etc/polipo/config

echo Configuring init scipts…
echo xenodm_flags=YES > /etc/rc.conf.local
echo pkg_scripts=$PKG_SCRIPTS >> /etc/rc.conf.local

echo Restarting services…
rcctl restart $PKG_SCRIPTS sshd

echo Adding tor user…
useradd -m tor
mkdir ~tor/.ssh
cp ~vagrant/.ssh/authorized_keys ~tor/.ssh/
echo "ProxyCommand socat STDIO SOCKS4A:localhost:%h:%p,socksport=9050" > ~tor/.ssh/config
proxy=http://127.0.0.1:8123
mkdir ~tor/.w3m
echo "http_proxy $proxy
https_proxy $proxy
ftp_proxy $proxy
use_proxy 1" > ~tor/.w3m/config
echo "
export http_proxy=$proxy
export https_proxy=$proxy
export all_proxy=$proxy
export ftp_proxy=$proxy
export PKG_PATH=$PKG_PATH
lynx -width=1000 -dump -nolist http://check.torproject.org/  | head -n 7 | tail -n 3
" > ~tor/.profile
chown -R tor:tor ~tor

echo 'lynx -width=1000 -dump -nolist http://check.torproject.org/  | head -n 7 | tail -n 3' > ~vagrant/.profile

echo Setting up packet filter rule…
echo 'block out on ! lo0 proto { tcp, udp } user tor' >> /etc/pf.conf
pfctl -f /etc/pf.conf

# disable sudo
# mv /etc/sudoers{,.bak}

echo Bootstap done!
