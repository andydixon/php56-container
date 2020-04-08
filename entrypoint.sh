#!/bin/bash
chown -R www-data /var/www/html
echo "myhostname=hephaestus.dxn.pw" >> /etc/postfix/main.cf
service postfix start
apachectl -D FOREGROUND
tail -f /var/log/syslog
