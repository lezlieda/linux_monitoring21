#!/usr/bin/bash

# set a regular expression for numbers and compare parameter with it
# '=~' is used to compare string to regexp

num="^[-+]?[0-9]*[.,]?[0-9]*$"
if [[ $1 =~ $num ]]
then
	echo "Invalid input!"
else
	echo $1
fi
