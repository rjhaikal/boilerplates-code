# Port Forwarder Script

## Use Case

For example, you have a Server that has virsh installed on it, and you want to direct SSH to the vm without having to SSH to your server first.

## How To Use

```
virsh list

 Id   Name        State
---------------------------
 1    rj-lab      running

./portforward.sh

IP VM who want to exposed (x.x.x.x:port):192.168.1.10:22
Enter Port Access:8090

VM with IP 192.168.1.10:22 will be publicly on {IP Public}:8090
```