#!/usr/bin/bash

path="$1"

exec_ext="exec_files_extensions.txt"
arch_ext="arch_files_extensions.txt"

function ext_counter() {
	local files=0
	if [ -f "$2" ]
	then
		while IFS='=' read -r ext info; do
			local num=$(find $3* -type f -name "*$ext" 2>/dev/null | wc -l)
			((files=files+num))
		done < $2
	fi
	return $(( $files ))	
}

number_of_folders=$(find $1* -type d 2>/dev/null | wc -l)
top_five=$(find $1* -type d -exec du --apparent-size -h {} + 2>/dev/null | sort -hr | sed -r 's/([0-9])([GMK])/\1 \2B/; s/(^[0-9]*)(\t)/\1 B\2/' | head -5 | cat -n | awk '{print $1" - "$4", "$2" "$3}')
number_of_files=$(find $1* -type f 2>/dev/null | wc -l)
conf_files=$(find $1* -type f -name "*.conf" 2>/dev/null | wc -l)
text_files=$(find $1* -type f -exec grep -Iq . 2>/dev/null {} \; -print | wc -l)
log_files=$(find $1* -type f -name "*.log" 2>/dev/null | wc -l)
ext_counter $1 "$arch_ext" $path
arch_files=$?
sym_links=$(find $1* -type l 2>/dev/null | wc -l)
top_ten_files=$(find $1* -type f 2>/dev/null -exec du --apparent-size -h {} + | sort -hr | sed -r 's/([0-9])([GMK])/\1 \2B/; s/(^[0-9]*)(\t)/\1 B\2/' | head -10 | cat -n | awk '{
ext = $4
gsub(/(.*)\//, "", ext)
tmp = ext
gsub(/(.*)\./, "", ext)
nums = "^[0-9]*$"
if (ext == tmp || length(ext) == length(tmp) - 1 || ext ~ nums) ext = "no type specified"
printf("%s - %s, %s %s, %s\n", $1, $4, $2, $3, ext) }')

exec_files=$(find $1* -type f -executable -exec du --apparent-size -h {} + 2>/dev/null)


if [ -f "$exec_ext" ]
then
		while IFS='=' read -r ext info; do
			exec_files+=$(echo -e " \n ")
			exec_files+=$(find $path* -type f -name "*$ext"  -exec du --apparent-size -h {} + 2>/dev/null)
		done < "$exec_ext"
fi

exec_files=$(echo "$exec_files" | sed -e 's/^ //; s/ $//; s/^$//' | sort -u)
exec_files_num=$(echo "$exec_files" | wc -l) 
top_ten_exec=$(echo "$exec_files" | sort -hr | head -10)
