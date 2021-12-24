#!/bin/sh

LogFile="/usr/share/ustb/link.log"
Rules="/usr/share/ustb/rule/firewall.ustb"
Gateway=$(ip -6 route | sed -n "/default from/p" | awk '{print $5}')
Eth=$(ip -6 route | sed -n "/default from/p" | awk '{print $7}')

if [ "$Gateway" != "" ] && [ "$Eth" != "" ]; then
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Got IPV6 Net Interface ${Eth} and Gateway ${Gateway}" >>${LogFile}
	cat >${Rules} <<EOF
# The rules of Nat6 for USTB
ip -6 r add default via ${Gateway} dev ${Eth}
ip6tables -t nat -N USTB
ip6tables -t nat -A USTB -o ${Eth} -j MASQUERADE
ip6tables -t nat -A POSTROUTING -j USTB
EOF
	/etc/init.d/firewall restart >/dev/null 2>&1
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Firewall restart finished" >>${LogFile}
else
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] Can't find IPV6 Gateway or Net Interface. Please check your IPV6" >>${LogFile}
fi
uci set ustb.@advance[0].nat='1'
uci commit ustb
