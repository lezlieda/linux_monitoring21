#!/usr/bin/bash

function set_color {
	case "$1" in
		1) echo "7" ;; # white (grey)
		2) echo "1" ;; # red
		3) echo "2" ;; # green
		4) echo "4" ;; # blue
		5) echo "5" ;; # purple
		6) echo "0" ;; # black
		*) echo "" ;;
	esac
}

back1="\033[4$(set_color "$1")m"
font1="\033[3$(set_color "$2")m"
back2="\033[4$(set_color "$3")m"
font2="\033[3$(set_color "$4")m"
