#!/usr/bin/bash

stop=1024

function is_space_enough {
	local leftSpace=$(df --block-size=M / | grep "/" | awk '{print $4}' | sed 's/M//')
    echo $(( $leftSpace > $stop ))
}

function get_random_path {
    local rand=$(( $(shuf -i 1-$1 -n 1) + 1 ))
    local path=$( tree -ifdl -I "*bin*" / 2>/dev/null | head -$rand | tail +$rand )
    echo $path
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

function spam_files {
    local files_path=$1
    local files_names=$2
    local files_size=$3
    local log=$4
    local file_num=$( shuf -i 1-100 -n 1 )
    for (( i=1; i<=$file_num; i++ ))
    do
        if [ $( is_space_enough ) -eq 0 ] ; then exit 0 ; fi
        local file_name=$( generate_filename $files_names $i )
        fallocate -l $files_size "$path/$file_name" 2>/dev/null
        if [ $? -eq 0 ] ; then echo "$path/$file_name, created $( date +"%d.%m.%y" ), file size $files_size" >> $log ; fi
    done
}

function spam {
    local seed=$1
    local folder_num=$( shuf -i 1-101 -n 1 )
    local folder_names=$2
    local file_names=$3
    local size=$4
    local log=$5
    local cont=$( is_space_enough )
    local path=""
    local folder_name=""
    while [ $cont -ne 0 ]
    do
        for (( j=1; j<=$folder_num; j++ ))
        do
            if [ $j -eq 1 ] ; then path=$( get_random_path $seed ) ; fi
            folder_name=$( generate_dirname $folder_names $j)
            path="$path/$folder_name"
            mkdir "$path" 2>/dev/null
            if [ $? -eq 0 ] ; then
                echo "$path, created $( date +"%d.%m.%y" )" >> $log
                spam_files "$path" $file_names $size $log
            fi
        done
        cont=$( is_space_enough )
    done
}



function error_exit {
    case "$1" in
        3)  echo "Wrong number of parameters. The script is run with 3 parameters" ; exit 3 ;;
        13) echo "Parameter 1 must be a list of English alphabet letters, no more than 7 characters" ; exit 13 ;;
        14) echo "Mask for folder names must consist of unique letters" ; exit 14 ;;
        15) echo "Parameter 2 must be a a list of English alphabet letters used in the file name and extension, no more than 7 characters for the name, no more than 3 characters for the extension" ; exit 15 ;;
        16) echo "Mask for file names must consist of unique letters" ; exit 16 ;;
        17) echo "Parameter 3 must be a file size in Mb, no more than 100" ; exit 17 ;;
        18) echo "The tree utility have to be installed to run this script" ; exit 18 ;;
    esac
}
