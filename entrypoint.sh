#!/bin/bash
apachectl -D FOREGROUND
tail -f /var/log/syslog
