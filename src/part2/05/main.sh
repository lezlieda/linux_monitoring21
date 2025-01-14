#!/usr/bin/bash

. lib.sh
. input_checker.sh

case "$1" in
    1) sort_by_responce ;;
    2) uniq_ip ;;
    3) error_requests ;;
    4) uniq_ip_error_requests ;;
esac
