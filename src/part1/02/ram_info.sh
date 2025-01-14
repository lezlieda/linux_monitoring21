#!/usr/bin/bash

RAM_TOTAL=$(free | awk '/Mem/{printf "%.3f GB", $2/1024/1024}')
RAM_USED=$(free | awk '/Mem/{printf "%.3f GB", $3/1024/1024}')
RAM_FREE=$(free | awk '/Mem/{printf "%.3f GB", $4/1024/1024}')
