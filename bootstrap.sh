#!/bin/sh
. /root/.profile

HOSTNAME=$1

# bring up bridged interface and set hostname
echo dhcp > /etc/hostname.em1
echo $HOSTNAME
hostname -s $HOSTNAME > /etc/myname
sh /etc/netstart em1

#configure mail server
touch /etc/mail/nospamd
/etc/rc.d/sendmail stop
sed -e 's#/.*sendmail$#/usr/sbin/smtpctl#; s#/.*makemap$#/usr/libexec/smtpd/makemap#; s#^\(newaliases\).*#\1      /usr/libexec/smtpd/makemap#' /etc/mailer.conf > /tmp/mailer.conf
cat /tmp/mailer.conf > /etc/mailer.conf
newaliases
echo "sendmail_flags=NO" >> /etc/rc.conf.local
echo "smtpd_flags=" >> /etc/rc.conf.local
echo "spamd_flags=" >> /etc/rc.conf.local
/etc/rc.d/smtpd start
/etc/rc.d/spamd start

echo '
# rules for spamd(8)
egress =  "em1"
table <spamd-white> persist
table <nospamd> persist file "/etc/mail/nospamd"
pass in on $egress proto tcp from any to any port smtp \
    rdr-to 127.0.0.1 port spamd
pass in on $egress proto tcp from <nospamd> to any port smtp
pass in log on $egress proto tcp from <spamd-white> to any port smtp
pass out log on $egress proto tcp to any port smtp
' >> /etc/pf.conf
pfctl -f /etc/pf.conf
echo "sysctl net.inet.ip.forwarding=1" | tee -a /etc/sysctl.conf | sh
