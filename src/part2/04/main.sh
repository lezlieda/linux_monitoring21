#!/usr/bin/bash

. lib.sh

for (( i = 1; i < 6; i++)); do
    day=$( generate_date )
    lines=$( shuf -i 100-1000 -n 1 )
    touch "access_log-$i.log"
    for (( j = 0; j < $lines; j++ )); do
        ip=$(generate_ip)
        time=$(generate_date_time $day $lines $j)
        responce=$(shuf -n 1 -e "${responces[@]}")
        method=$(shuf -n 1 -e "${methods[@]}")
        resource=$(shuf -n 1 -e "${files[@]}")
        http_ref=$(shuf -n 1 -e "${urls[@]}")/$resource
        agent=$(shuf -n 1 -e "${agents[@]}")
        echo "$ip - - $time \"$method /$resource HTTP/1.0\" $responce $RANDOM \"$http_ref\" \"$agent\"" >> "access_log-$i.log"
    done
done