#!/usr/bin/bash

# If number of parameters not equal to 4, error code 55
if [ $# -ne 4 ]
then
	exit 55
fi

# If one of the parameters is wrong, error code 77
num="^[1-6]$"
for i in $@
do
	if [[ ! $i =~ $num ]]
	then
		exit 77 
	fi
done

# If first two or last two parameters are equal, error code 99  
if [[ $1 = $2 ]] || [[ $3 = $4 ]]
then
	exit 99
fi
