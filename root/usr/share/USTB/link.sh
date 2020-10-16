#!/bin/sh
log_file="/usr/share/USTB/link.log"
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
        [ "$ipv6" != "" ] && echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address:[${ipv6}]" >>$log_file || echo "[$(date +'%Y-%m-%d %H:%M:%S')] IPV6 Address Can't be found" >>$log_file
    else
        ipv6=""
    fi
    $(curl -sd "DDDDD=${USER}&upass=${PASSWORD}&v6ip=${ipv6}&0MKKey=123456789" ${Login_IP}) >/dev/null
}

check() {
    [ $(curl -I -m 4 -o /dev/null -s -w %{http_code}"\n" "${URL}") == 200 ] && Error=0 || Error=1
}

if [ "$V6" == "1" ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V6" >>$log_file
    [ "$TEST_V6URL" != "" ] && URL=$TEST_V6URL || URL='http://cippv6.ustb.edu.cn/get_ip.php'
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] Check Connections with V4" >>$log_file
    [ "$TEST_V4URL" != "" ] && URL=$TEST_V4URL || URL='https://www.baidu.com/'
fi

while true; do
    file_size=$(du -a /root/link.log | awk '{print $1}')
    check
    if [ $Error != 0 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Curl failed, now will try to connect USTB network" >>$log_file
        while [ $Error != 0 ]; do
            connection
            sleep 3
            check
        done
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] Connecting to ${Login_IP}" >>$log_file
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
