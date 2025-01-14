#!/usr/bin/bash

interface=$(echo $(ls /sys/class/net) | awk '{print $1}')
ipa=$(ip a | grep "inet" | grep "$interface")

IP=$(echo $ipa | awk '{print $2}' | sed 's/\/[0-9]*//')
MASK=$(ipcalc $IP | grep "Netmask" | awk '{print $2}')
GATEWAY=$(ip r | awk '/default via/ {print $3}')
