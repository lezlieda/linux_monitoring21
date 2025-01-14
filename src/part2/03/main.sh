#!/usr/bin/bash

. lib.sh

if [[ $# -ne 1 ]] ; then
    error_exit 14
fi

export mode=$1

case "$mode" in
	1)  echo "Enter the path to the log file:" ; read path ;;
	2)  echo "Enter the start date and time in format: dd.mm.yyyy:hh:ss"
        read start_time 
        check_time_format $start_time
        echo "Enter the end date and time in format: dd.mm.yyyy:hh:ss"
        read finish_time
        check_time_format $finish_time ;;
    3)  echo "By name mask (i.e. characters, underlining and date)" ; read mask
        check_mask $mask;;
	*)  error_exit 6 ;;
esac

if [[ mode -eq 1 ]] ; then
    if [ -f "$path" ] ; then
        while read line; do
            dir=$( echo "$line" |  awk '{print $1}' | sed 's/\,$//')
            rm -rf "$dir"
        done < $path
    else
        error_exit 15
    fi
elif [[ mode -eq 2 ]] ; then
    start_time_birth=$( convert_time $start_time 1 )
    finish_time_birth=$( convert_time $finish_time 1 )
    check_times $start_time_birth $finish_time_birth
    start_time_find=$( convert_time $start_time 2 )
    finish_time_find=$( convert_time $finish_time 2 )
    list=$( find / -type d -newermt "$start_time_find" ! -newermt "$finish_time_find" 2>/dev/null)
    while read line; do
        path=$( echo "$line" | awk '{print $1}' )
        time_birth=$( get_creation_time $path )
        if [ "$time_birth" \> "$start_time_birth" ] && [ "$time_birth" \< "$finish_time_birth" ]; then
            echo "$path"
            rm_list+=$( printf "%s\n"$path )
        fi
    done <<< "$list"
    read -p "Do you really want to delete all these directories? (Y/y/n)"
    if [[ $REPLY =~ [Yy] ]]; then
        echo "$rm_list" | xargs -d "\n" rm -rf
    fi
elif [[ mode -eq 3 ]] ; then
    letters=$( echo "$mask" | sed 's/[0-9]//g' | sed 's/\_//g' )
    numbers=$( echo "$mask" | sed 's/[a-z]//g' | sed 's/\_//g' )
    len_letters=${#letters}
    pat=""
    for (( i = 0; i < len_letters; i++ )); do
        letter=${letters:$i:1}
        pat+="["
        pat+="$letter"
        pat+="]+"
    done
    pat+="_$numbers$"
    find / -type d 2>/dev/null | grep -P "$pat" | xargs -d "\n" rm -rf
fi
