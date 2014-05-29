#!/bin/bash

LogFile="/var/log/iptables.log"

Size=`wc -l $LogFile|cut -d" " -f1`

if [ $Size == '0' ];then
	exit 0
else
	IP=`cat /var/log/iptables.log |grep "WEB Attack"|awk -F" " '{print $10}'|uniq`
	for i in $IP
	do
		ip=`echo $i|cut -d"=" -f2`
			/sbin/iptables -I INPUT -s $ip -p tcp -m multiport --destination-ports 25,110,143,80,934,935,443 -j DROP 
			echo $ip >> BlackIp.log
			service iptables save &> /dev/null

	done
	echo $IP | mail -s "Ip Attack" yfzhang7@iflytek.com
	cat /dev/null > $LogFile
fi 

