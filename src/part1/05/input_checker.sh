#!/usr/bin/bash

# If number of parameters not equal to 1, error code 55
# If parameter does not end with '/', error code 66
# If no such directory, error code 77
if [ $# -ne 1 ]
then
	exit 55
elif [[ "${1: -1}" != "/" ]]
then
	exit 66
elif ! [ -d $1 ]
then
	exit 77
fi
