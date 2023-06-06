#/bin/bash
iptables -t nat -v -L -n --line-number
echo -n "IP VM who want to exposed (x.x.x.x:port): "
read ip_vm
echo $ip_vm

echo -n "Enter Port Access: " 
read port
echo $port
echo "Will be accessible on port $port"

iptables -t nat -A PREROUTING -p tcp --dport $port -d {IP Public} -j DNAT --to-destination $ip_vm

iptables -t nat -v -L -n --line-number
echo "VM with IP $ip_vm will be publicly on {IP Public}:$port"
echo "Escalation Succesfully"