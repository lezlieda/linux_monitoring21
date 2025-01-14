#!/usr/bin/bash

. system_info.sh
. network_info.sh
. ram_info.sh
. disk_info.sh
. set_color.sh

end="\033[0m"
echo -e "       ${back1}${font1}HOSTNAME${end} = ${back2}${font2}${HOSTNAME}${end}"
echo -e "        ${back1}${font1}IMEZONE${end} = ${back2}${font2}${TIMEZONE}${end}"
echo -e "           ${back1}${font1}USER${end} = ${back2}${font2}${USER}${end}"
echo -e "             ${back1}${font1}OS${end} = ${back2}${font2}${OS}${end}"
echo -e "           ${back1}${font1}DATE${end} = ${back2}${font2}${DATE}${end}"
echo -e "         ${back1}${font1}UPTIME${end} = ${back2}${font2}${UPTIME}${end}"
echo -e "     ${back1}${font1}UPTIME_SEC${end} = ${back2}${font2}${UPTIME_SEC}${end}"
echo -e "             ${back1}${font1}IP${end} = ${back2}${font2}${IP}${end}"
echo -e "           ${back1}${font1}MASK${end} = ${back2}${font2}${MASK}${end}"
echo -e "        ${back1}${font1}GATEWAY${end} = ${back2}${font2}${GATEWAY}${end}"
echo -e "      ${back1}${font1}RAM_TOTAL${end} = ${back2}${font2}${RAM_TOTAL}${end}"
echo -e "       ${back1}${font1}RAM_USED${end} = ${back2}${font2}${RAM_USED}${end}"
echo -e "       ${back1}${font1}RAM_FREE${end} = ${back2}${font2}${RAM_FREE}${end}"
echo -e "     ${back1}${font1}SPACE_ROOT${end} = ${back2}${font2}${SPACE_ROOT}${end}"
echo -e "${back1}${font1}SPACE_ROOT_USED${end} = ${back2}${font2}${SPACE_ROOT_USED}${end}"
echo -e "${back1}${font1}SPACE_ROOT_FREE${end} = ${back2}${font2}${SPACE_ROOT_FREE}${end}"
