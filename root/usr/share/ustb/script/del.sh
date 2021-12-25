#!/bin/sh

LogFile="/usr/share/ustb/link.log"
Rules="/usr/share/ustb/rule/firewall.ustb"

echo "[$(date +'%Y-%m-%d %H:%M:%S')] Delete Nat6 rules" >>${LogFile}
cat >${Rules} <<EOF
# The rules of Nat6 for USTB
EOF

/etc/init.d/firewall restart >/dev/null 2>&1
uci set ustb.@advance[0].nat='0'
uci commit ustb
