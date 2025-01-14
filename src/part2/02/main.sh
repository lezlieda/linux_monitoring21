#!/usr/bin/bash

. input_checker.sh
. lib.sh

cont=$( is_space_enough )

total_folders=$( echo $(( $(tree -ifd -I "*bin*" / | wc -l) - 3 )) )

logname=$( echo "spam_$( date +"%d_%m_%y_%H_%M_%S" ).log" )
touch "$logname"

# spam_files ./ ac.cv 4Mb "$logname"

spam $total_folders $1 $2 $3 $logname
