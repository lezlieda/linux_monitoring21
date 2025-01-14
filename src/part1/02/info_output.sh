#!/usr/bin/bash

# '.' is equal to 'source' - connecting the libraries
. system_info.sh
. network_info.sh
. ram_info.sh
. disk_info.sh

echo "       HOSTNAME = $HOSTNAME"
echo "       TIMEZONE = $TIMEZONE"
echo "           USER = $USER"
echo "             OS = $OS"
echo "           DATE = $DATE"
echo "         UPTIME = $UPTIME"
echo "     UPTIME_SEC = $UPTIME_SEC"
echo "             IP = $IP"
echo "           MASK = $MASK"
echo "        GATEWAY = $GATEWAY"
echo "      RAM_TOTAL = $RAM_TOTAL"
echo "       RAM_USED = $RAM_USED"
echo "       RAM_FREE = $RAM_FREE"
echo "     SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
