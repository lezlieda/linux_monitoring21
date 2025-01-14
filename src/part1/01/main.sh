#!/usr/bin/bash

# pass all parameters to the first script and if it returns 0
# pass the first parameter to the second script

bash counter.sh $* && bash checker.sh $1
