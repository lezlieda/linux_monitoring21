#!/usr/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{printf("%s UTC %+d\n", $3, $5/100)}')
USER=$(whoami)
OS=$(lsb_release -d -s)
DATE=$(date +"%d %B %Y %T")
UPTIME=$(uptime -p | sed 's/up //')
UPTIME_SEC=$(awk '{print $1}' /proc/uptime)

