#!/usr/bin/bash

function error_exit {
    case "$1" in
        10) echo "Wrong number of parameters. The script is run with 1 parameter" ; exit 10 ;;
        11) echo "Parameter may be only 1, 2, 3 or 4" ; exit 11 ;;
    esac
}

function sort_by_responce {
    sort -k9 -n access_log-*.log
}

function uniq_ip {
    cat access_log-*.log | awk '{print $1}' | uniq
}

function error_requests {
    awk '$9 ~ /[45][0-9][0-9]/' access_log-*.log
}

function uniq_ip_error_requests {
    awk '$9 ~ /[45][0-9][0-9]/' access_log-*.log | awk '{print $1}' | uniq
}