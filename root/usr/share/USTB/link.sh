#!/bin/sh
log_file="/usr/share/USTB/link.log"
num=0
Date=""
USER=$(uci get ustb.@login[0].username)
PASSWORD=$(uci get ustb.@login[0].password)
V6=$(uci get ustb.@login[0].enableV6)
if [ "$V6" == "1" ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V6" >>$log_file
    Domain='ssr.jarao.work'
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V4" >>$log_file
    Domain='www.baidu.com'
fi
while true; do
    file_size=$(du -a /root/link.log | awk '{print $1}')
    ping -c 4 $Domain >/dev/null
    if [ $? != 0 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Ping failed, now will try to connect USTB network" >>$log_file
        if [ "$V6" == "1" ]; then
            ipv6=$(ip -6 address show | grep '2001:da8:208' | awk '{print $2}' | cut -d '/' -f1)
            [ "$ipv6" != ""] && echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address:${ipv6}" >>$log_file || echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address Can't be found" >>$log_file
        else
            ipv6=""
        fi
        $(curl -sd "DDDDD=${USER}&upass=${PASSWORD}&v6ip=${ipv6}&0MKKey=123456789" 202.204.48.82) >/dev/null
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Connected" >>$log_file
    else
        if [ $(expr $num % 100) == 0 ]; then
            echo "[$(date +'%Y-%m-%d %H:%M:%S')] The Connection is normal:${num}" >>$log_file
        fi
        sleep 36
        num=$((num + 1))
    fi
    if [ $(expr $file_size) -ge 1024 ]; then
        echo -n "" >$log_file
        echo 1024 >>$log_file
    fi
done
