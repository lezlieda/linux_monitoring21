#!/usr/bin/bash

SPACE_ROOT=$(df / | grep "/" | awk '{printf "%.2f MB", $2/1024}')
SPACE_ROOT_USED=$(df / | grep "/" | awk '{printf "%.2f MB", $3/1024}')
SPACE_ROOT_FREE=$(df / | grep "/" | awk '{printf "%.2f MB", $4/1024}')
