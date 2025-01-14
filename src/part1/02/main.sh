#!/usr/bin/bash

bash info_output.sh

read -p "Do you want to save data to a file? (Y/N): "
if [[ $REPLY =~ [yY] ]]
then
	file="$(date +"%d_%m_%y_%H_%M_%S.status")"
	bash info_output.sh >> $file
fi
