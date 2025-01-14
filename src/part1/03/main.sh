#!/usr/bin/bash

bash input_checker.sh $*

ret=($echo $?)

if [ $ret -eq 55 ]
then
	echo "Invalid number of parameters, it should be 4."
	exit 13
elif [ $ret -eq 77 ]
then
	echo "Parameters specified incorrectly, their values should be [1 - 6]"
	exit 14
elif [ $ret -eq 99 ]
then
	echo "The font and the background of the same column must not match, re-invoke the script with different parameters"
	exit 0
elif [ $ret -eq 0 ]
then
	bash info_output.sh $*
fi

