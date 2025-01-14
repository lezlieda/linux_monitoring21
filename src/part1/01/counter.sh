#!/usr/bin/bash

# if the number of parameters is not equal to 1
# print a message and exit with error

if [ $# -ne 1 ]
then
	echo "Invalid input!"
	exit 3
fi
