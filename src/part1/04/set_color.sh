#!/usr/bin/bash

function set_color {
	case "$1" in
		1) echo "7" ;;
		2) echo "1" ;;
		3) echo "2" ;;
		4) echo "4" ;;
		5) echo "5" ;;
		6) echo "0" ;;
		16) echo "0" ;;
		11) echo "7" ;;
		12) echo "1" ;;
		14) echo "4" ;;
#		*) echo "" ;;
	esac
}

function name_color {
	case "$1" in
		1) echo "1 (whit)e" ;;
		2) echo "2 (red)" ;;
		3) echo "3 (green)" ;;
		4) echo "4 (blue)" ;;
		5) echo "5 (purple)" ;;
		6) echo "6 (black)" ;;
		16) echo "default (black)" ;;
		11) echo "default (white)" ;;
		12) echo "default (red)" ;;
		14) echo "default (blue)" ;;
#		*) echo "" ;;
	esac
}

# Open the configuration file and read from it
colors="colors.conf"
if [ -f "$colors" ]
then
	while IFS='=' read -r name num; do
		if [[ -n "$name" ]]
		then
			case "$name" in
				column1_background) b1=$num ;;
				column1_font_color) f1=$num ;;
				column2_background) b2=$num ;;
				column2_font_color) f2=$num ;;
			esac
		fi
	done < $colors
fi

# If no or invalid input
accepted="^[1-6]$"
if [[ ! $b1 =~ $accepted ]]
then
	b1=16
fi

if [[ ! $f1 =~ $accepted ]]
then
	f1=11
fi

if [[ ! $b2 =~ $accepted ]]
then
	b2=12
fi

if [[ ! $f2 =~ $accepted ]]
then
	f2=14
fi

# If background and font are same
let col1=b1-f1
if [[ $col1 -eq 0 ]] || [[ $col1 -eq 10 ]] || [[ $col1 -eq -10 ]]
then
	b1=16
	f1=11
fi
let col2=b2-f2
if [[ $col2 -eq 0 ]] || [[ $col2 -eq 10 ]] || [[ $col2 -eq -10 ]]
then
	b2=12
	f2=14
fi

# And finally set colors
back1="\033[4$(set_color "$b1")m"
font1="\033[3$(set_color "$f1")m"
back2="\033[4$(set_color "$b2")m"
font2="\033[3$(set_color "$f2")m"

