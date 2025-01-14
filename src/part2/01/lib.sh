#!/usr/bin/bash

stop=1024

function is_space_enough {
	local leftSpace=$(df --block-size=M / | grep "/" | awk '{print $4}' | sed 's/M//')
    echo $(( $leftSpace > $stop ))
}

function check_list {
    local len=${#1}
    for (( i = 0; i < $len; i++ )); do
        for (( j = i + 1; j < $len; j++ )); do
            if [ ${1:i:1} == ${1:j:1} ] ; then
                return 1
            fi
        done
    done
}

function generate_name {
    local pattern=$1
    local length=${#pattern}
    local generation=$2
    if [ $length -le 2 ] ; then
        generation=$(($generation + 4 - $length))
    fi
    local index=$((generation % length - 1))
    local times=$(((generation - 1)/ length + 1))
    local char=${pattern:$index:1}
    insert=$(printf %"$times"s | tr " " $char)
    printf "%s%s%s" ${pattern: 0: $index} $insert ${pattern: $index}
}

function generate_dirname {
    echo "$( generate_name $1 $2 )_$( date +"%d%m%y" )"
}

function generate_filename {
    local file_name_pattern=$( echo $1 | sed 's/\..*//' )
    local file_extension=$( echo $1 | sed 's/.*\././' )
    local filename=$( generate_name $file_name_pattern $2 )$file_extension
    echo $filename
}

function spam {
    local path=$1
    local number=$(( $2 + 1 ))
    local folder_names=$3
    local num_of_files=$4
    local file_names=$5
    local file_size=$6
    local log=$7
	local lap=$8
    local gen=0
	for (( i=0; i<$number; i++ ))
	do
		if [[ i -eq 0 ]] ; then
			gen=$(($i + 1 + $lap))
		else
			gen=$i
		fi
		folder_name=$( generate_dirname $folder_names $gen )
		mkdir "$path/$folder_name"
        if [ $? -eq 0 ] ; then echo "$path/$folder_name, created $( date +"%d.%m.%y" )" | sed 's/\/\//\//g' >> "$log" ; fi
		path=$( echo "$path/$folder_name/" | sed 's/\/\//\//g' )
		for (( j=1; j<=$num_of_files; j++ ))
		do
			if [ $( is_space_enough ) -eq 0 ] ; then
				exit 0
			fi
			filename=$( generate_filename $file_names j)
			fallocate -l $file_size "$path$filename"
			if [ $? -eq 0 ] ; then echo "$path$filename, created $( date +"%d.%m.%y" ), file size = $file_size" >> "$log" ; fi
		done
	done
}

function error_exit {
    case "$1" in
        6) echo "Wrong number of parameters. The script is run with 6 parameters" ; exit 6 ;;
        11) echo "First parameter must be absolute path" ; exit 11 ;;
        111) echo "Wrong path" ; exit 111 ;;
        12) echo "Parameter 2 must be a number" ; exit 12 ;;
        13) echo "Parameter 3 must be a list of English alphabet letters, no more than 7 characters" ; exit 13 ;;
        23) echo "Parameter 3 must be a list of unique English alphabet letters, no more than 7 characters" ; exit 23 ;;
        14) echo "Parameter 4 must be a number greater than 0" ; exit 14 ;;
        15) echo "Parameter 5 must be a a list of English alphabet letters used in the file name and extension, no more than 7 characters for the name, no more than 3 characters for the extension" ; exit 15 ;;
        25) echo "Parameter 5 must be a list of unique English alphabet letters, no more than 7 characters for the name, no more than 3 characters for the extension" ; exit 25 ;;
        16) echo "Parameter 6 must be a file size in kb, no more than 100" ; exit 16 ;;
    esac
}


