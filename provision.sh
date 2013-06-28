#!/bin/sh
. /root/.profile

touch /etc/mail/nospamd

/etc/rc.d/sendmail stop
sed -e 's#/.*sendmail$#/usr/sbin/smtpctl#; s#/.*makemap$#/usr/libexec/smtpd/makemap#; s#^\(newaliases\).*#\1      /usr/libexec/smtpd/makemap#' /etc/mailer.conf > /tmp/mailer.conf
cat /tmp/mailer.conf > /etc/mailer.conf
newaliases
echo "sendmail_flags=NO" >> /etc/rc.conf.local
echo "smtpd_flags=" >> /etc/rc.conf.local
echo "spamd_flags=" >> /etc/rc.conf.local
/etc/rc.d/smtpd start
