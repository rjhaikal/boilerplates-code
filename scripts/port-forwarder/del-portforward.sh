#/bin/bash

iptables -t nat -v -L -n --line-number

echo -n "Please enter type IP Tables (PREROUTING/POSTROUTING): " 
read TYPE
#echo $TYPE

echo -n "Please enter line number who want you to delete: " 
read number
#echo $number

iptables -t nat --delete $TYPE $number
echo "IP Tables with Line number $number & $TYPE type has been deleted"
iptables -t nat -v -L -n --line-number