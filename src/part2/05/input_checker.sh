#!/usr/bin/bash

. lib.sh

if [ $# -ne 1 ] ; then
    error_exit 10
elif ! [[ $1 =~ ^[1-4]$ ]] ; then
    error_exit 11
fi
