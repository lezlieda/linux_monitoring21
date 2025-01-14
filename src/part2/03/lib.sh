#!/usr/bin/bash

# find . -type d | grep -P "[a]+[b]+[c]+[d]+_040723$"

function error_exit {
    case "$1" in
        14) echo "Wrong amount of parameters! The script is run with 1 parameter."; exit 14 ;;
        15) echo "Wrong path to the log file!" ; exit 15 ;;
        16) echo "Wrong date input!" ; exit 16 ;;
        17) echo "Wrong time input!" : exit 17 ;;
        18) echo "Wrong date & time input!" ; exit 18 ;;
        19) echo "Wrong pattern input!" ; exit 19 ;;
    esac
}

function digit_month {
    case "$1" in
        "Jan") echo "01" ;;
        "Feb") echo "02" ;;
        "Mar") echo "03" ;;
        "Apr") echo "04" ;;
        "May") echo "05" ;;
        "Jun") echo "06" ;;
        "Jul") echo "07" ;;
        "Aug") echo "08" ;;
        "Sep") echo "09" ;;
        "Oct") echo "10" ;;
        "Nov") echo "11" ;;
        "Dec") echo "12" ;;
    esac
}

function get_creation_time {
    local inode=$( stat -c "%i" "$1" )
    # fs=$( df  --output=source "$1" | tail -1 )
    local fs=$( df  --output=source / | tail -1 )
    local crtime=$( sudo debugfs -R 'stat <'"$inode"'> ' "$fs" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' )
    local year=$( echo $crtime | awk '{print $5}' )
    local month=$( echo $crtime | awk '{print $2}' )
    month=$( digit_month $month )
    local day=$( echo $crtime | awk '{print $3}' | sed 's/^.$/0&/' )
    local time=$( echo $crtime | awk '{print $4}' )
    local hour=${time:0:2}
    local minute=${time:3:2}
    echo "$year.$month.$day:$hour:$minute"
}

function clean_by_log {
    if [ -f $1 ] ; then
        while IFS= read -r line; do
            dir=$( echo "$line" | awk '{print $1}' | sed 's/,$//' )
            echo "$line"
        done < $1
        echo "i = $i"
    else
        error_exit 15
    fi
}

function check_time_format {
    local dd=${1:0:2}
    local mm=${1:3:2}
    local yyyy=${1:6:4}
    local hh=${1:11:2}
    local ss=${1:14:2}
    if [[ ${1:2:1} != "." ]] || [[ ${1:5:1} != "." ]] || [[ ${1:10:1} != ":" ]] || [[ ${1:13:1} != ":" ]] ; then
        error_exit 16
    fi
    date -d "$mm/$dd/$yyyy" > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        error_exit 16
    fi
    date -d "$hh:$ss" > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        error_exit 17
    fi
}

function convert_time {
    local dd=${1:0:2}
    local mm=${1:3:2}
    local yyyy=${1:6:4}
    local hh=${1:11:2}
    local ss=${1:14:2}
    if [ $2 -eq 1 ] ; then
        echo "$yyyy.$mm.$dd:$hh:$ss"
    elif [ $2 -eq 2 ] ; then
        echo "$mm/$dd/$yyyy $hh:$ss"
    fi
}

function check_times {
    local t1=$1
    local t2=$2
    tn=$( date +"%Y.%m.%d:%H:%M" )
    if [ "$t1" \> "$tn" ] || [ "$t1" \> "$t2" ]; then
        error_exit 18
    fi
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

function check_mask {
    local pattern=$( echo "$1" | sed 's/_[0-9]\{6\}$//' )
    local date=$( echo "$1" | grep -oP "[0-9]{6}$" )
    local file_name="[a-zA-Z]{1,7}"
    if ! [[ $pattern =~ $file_name ]] || ! check_list $pattern ; then
        error_exit 19
    fi
    local ddate=$( echo "${date:2:2}/${date:0:2}/${date:4:2}" )
    date -d "$ddate" > /dev/null 2>&1
    if [[ $? -ne 0 ]] ; then
        error_exit 19
    fi
    local today=$( date +"%y%m%d" )
    ddate=$( echo "${date:4:2}${date:2:2}${date:0:2}" )
    if [ $ddate -gt $today ] ; then
        error_exit 19
    fi
}
