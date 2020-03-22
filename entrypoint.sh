#!/bin/bash
chown -R www-data /var/www/html
apachectl -D FOREGROUND
tail -f /var/log/syslog
