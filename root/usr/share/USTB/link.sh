#!/bin/sh
log_file="/usr/share/USTB/link.log"
num=0
Date=""
USER=$1
PASSWORD=$2
V6=$3
echo -n "" >$log_file
echo "[$(date +'%Y-%m-%d %H:%M:%S')] service start" >>$log_file
if [ $V6 == 1 ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] use v6 check connections" >>$log_file
    Domain='ssr.jarao.work'
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] use v4 check connections" >>$log_file
    Domain='www.baidu.com'
fi
while true; do
    file_size=$(du -a /root/link.log | awk '{print $1}')
    ping -c 4 $Domain >/dev/null
    if [ $? != 0 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] ping fail, now will try to link " >>$log_file
        if [ $V6 == 1 ]; then
            ipv6=$(ip -6 address show | grep '2001:da8:208' | awk '{print $2}' | cut -d '/' -f1)
            echo "[$(date +'%Y-%m-%d %H:%M:%S')] ipv6:${ipv6}" >>$log_file
        else
            ipv6=""
        fi
        $(curl -d "DDDDD=${USER}&upass=${PASSWORD}&v6ip=${ipv6}&0MKKey=123456789" 202.204.48.82) >/dev/null
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] connection finished" >>$log_file
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] connections right,times:${num}" >>$log_file
        sleep 36
        num=$((num + 1))
    fi
    if [ $(expr $file_size) -ge 1024 ]; then
        echo -n "" >$log_file
        echo 1024 >>$log_file
    fi
done
