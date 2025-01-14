#!/usr/bin/bash

. lib.sh

if [ $# -ne 3 ] ; then
	error_exit 3
fi

letters="[a-zA-Z]{1,7}"
if ! [[ $1 =~ $letters ]] ; then
	error_exit 13
elif ! check_list $1 ; then
	error_exit 14
fi

fileNames="^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$"
if ! [[ $2 =~ $fileNames ]] ; then
	error_exit 15
fi

fileName=$( echo $2 | sed 's/\..*//' )
if ! check_list $fileName ; then
	error_exit 16
fi

size="^[1-9][0-9]?Mb$|^100Mb$"
if ! [[ $3 =~ $size ]] ; then
	error_exit 17
fi

tree --version > /dev/null 2>&1
if [[ $? -ne 0 ]] ; then
	error_exit 18
fi
