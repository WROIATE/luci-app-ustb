#!/bin/sh
LogFile="/usr/share/USTB/link.log"
PidFile="/var/run/ustb.pid"
num=0
Date=""
USER=$(uci get ustb.@login[0].username)
PASSWORD=$(uci get ustb.@login[0].password)
V6=$(uci get ustb.@login[0].enableV6)
TEST_V4URL=$(uci get ustb.@advance[0].test_v4url)
TEST_V6URL=$(uci get ustb.@advance[0].test_v6url)
Login_IP=$(uci get ustb.@advance[0].login_ip)
Error=0
Enable=1

connection() {
    if [ "$V6" == "1" ]; then
        ipv6=$(ip -6 address show | grep '2001:da8:208' | awk '{print $2}' | cut -d '/' -f1)
        [ "$ipv6" != "" ] && echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address:[${ipv6}]" >>$LogFile || echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address Can't be found" >>$LogFile
    else
        ipv6=""
    fi
    curl -s -d "DDDDD=${USER}&upass=${PASSWORD}&v6ip=${ipv6}&0MKKey=123456789" ${Login_IP} >/dev/null 2>&1
}

check() {
    [ $(curl -I -m 4 -o /dev/null -s -w %{http_code}"\n" "${URL}") != 000 ] && Error=0 || Error=1
}

if [ -f $PidFile ];then
    echo "Error: The service is already runing"
    return
else
    echo $$ > $PidFile
fi

if [ "$V6" == "1" ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V6" >>$LogFile
    [ "$TEST_V6URL" != "" ] && URL=$TEST_V6URL || URL='https://v6.myip.la/' #使用ipip.net的API
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V4" >>$LogFile
    [ "$TEST_V4URL" != "" ] && URL=$TEST_V4URL || URL='https://www.baidu.com/'
fi

while true; do
    file_size=$(du -a ${LogFile} | awk '{print $1}')
    check
    if [ $Error != 0 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Curl failed, now will try to connect USTB network" >>$LogFile
        while [ $Error != 0 ]; do
            connection
            sleep 3
            check
        done
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Connecting to ${Login_IP}" >>$LogFile
    else
        sleep 36
        num=$((num + 1))
    fi
    if [ $(expr $file_size) -ge 128 ]; then
        echo -n "" >$LogFile
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Clean log, loop time:${num}" >>$LogFile
    fi
done
