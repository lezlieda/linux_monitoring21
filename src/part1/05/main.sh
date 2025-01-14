#!/usr/bin/bash

start_time=$(date +"%s%N")

bash input_checker.sh $*

ret=$(echo $?)

if [ $ret -eq 55 ]; then
	echo "The script must run with 1 parameter"
	exit 55
elif [ $ret -eq 66 ]; then
	echo "The parameter must end with '/'"
	exit 66
elif [ $ret -eq 77 ]; then
	echo "No such directory"
	exit 77
fi

. info_finder.sh

echo "Total number of folders (including all nested ones) = $number_of_folders"
if [[ $number_of_folders -ne 0 ]] ; then
	echo -e "TOP 5 folders of maximum size arranged in decreasing order (path and size):\n$top_five"
fi
echo "Total number of files = $number_of_files"
echo -e "Number of:\nConfiguration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $(($exec_files_num - 1))"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $arch_files"
echo "Symbolic links = $sym_links"
if [[ $number_of_files -ne 0 ]] ; then
	echo "TOP 10 files of maximum size arranged in decreasing order (path, size and type):"
	echo "$top_ten_files"
fi
if [[ $exec_files_num -ne 1 ]] ; then
	echo -e "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
	for (( i = 1; i < 11 ; i++ ))
	do
		exec_size=$(echo "$top_ten_exec" | head -$i | tail +$i | awk '{print $1}' | sed -r 's/([0-9])([GMK])/\1 \2B/')
		exec_size=$(echo "$exec_size" | sed -r 's/(^[0-9]*$)/\1 B/')
		exec_path=$(echo "$top_ten_exec" | head -$i | tail +$i | awk '{print $2}')
		if [[ -n $exec_path ]]
		then
			exec_hash="$(md5sum $exec_path 2>/dev/null| awk '{print $1}')"
			if [[ -z $exec_hash ]] ; then
				exec_hash="Permission denied. To see MD5 hash rerun with sudo"
			fi
			echo "$i - $exec_path, "$exec_size", $exec_hash"
		fi

	done
fi

finish_time=$(date +"%s%N")
echo "$(($finish_time - $start_time))" | awk '{ printf ("Script execution time (in seconds) = %.1f\n", $1/1000000000) }'
