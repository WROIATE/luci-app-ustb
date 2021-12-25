#!/bin/sh

fee=$(curl -s 202.204.48.82 | grep -o "\(fee\)='\(.*\)';x" | grep -o "[0-9]*")
if [ "$fee" != "" ]; then
	fee=$(expr $fee)
	fee=$(expr $fee / 100)
	Fee=$(expr $fee / 100).$(expr $fee % 100)
	echo $Fee
fi
