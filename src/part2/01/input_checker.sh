#!/usr/bin/bash

. lib.sh

if [ $# -ne 6 ] ; then
	error_exit 6
fi

if [[ "${1::1}" != "/" ]] ; then
	error_exit 11
elif ! [ -d $1 ] ; then
	error_exit 111
fi

subFolders="[0-9]"
if ! [[ $2 =~ $subFolders ]] ; then
	error_exit 12
fi

letters="[a-zA-Z]{1,7}"
if ! [[ $3 =~ $letters ]] ; then
	error_exit 13
elif ! check_list $3 ; then
	error_exit 23
fi

files="^[1-9][0-9]*$"
if ! [[ $4 =~ $files ]] ; then
	error_exit 14
fi

fileNames="^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$"
if ! [[ $5 =~ $fileNames ]] ; then
	error_exit 15
fi

fileName=$( echo $5 | sed 's/\..*//' )
fileExtension=$( echo $5 | sed 's/.*\././' )
if ! check_list $fileName ; then
	error_exit 25
fi

size="^[1-9][0-9]?kb$|^100kb$"
if ! [[ $6 =~ $size ]] ; then
	error_exit 16
fi
