#!/usr/bin/bash

. lib.sh

. input_checker.sh

logname=$( echo "spam_$( date +"%d_%m_%y_%H_%M_%S" ).log" )
touch "$logname"

absolute_path=$1
subfolders_number=$2
folder_names_pattern=$3
files_number=$4
file_names_pattern=$5
size=$6
logfile=$7
folders=0

cont=$( is_space_enough )

while [ $cont -ne 0 ] ; do
	spam $absolute_path $subfolders_number $folder_names_pattern $files_number $file_names_pattern $size $logname $folders
	cont=$( is_space_enough )
	folders=$(( $folders + 1 ))
done
