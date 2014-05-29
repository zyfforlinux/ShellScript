#!/bin/bash

function ShowBlackIp(){
	IP=`/sbin/iptables  -n -L|grep "^DROP"|awk -F" " '{print $4}'|uniq`
	echo $IP
}

function AddwhiteIp(){
	if iptables -n -L|grep "^ACCEPT"|grep "\<$1\>" &> /dev/null;then
		echo -e "\033[40;31m The White Ip have exists \033[0m"
	else
	/sbin/iptables -I INPUT -s $1 -j ACCEPT &> /dev/null
	if [ ! $? -eq 0 ];then
		echo -e "\033[40;31m IP ERROR\033[0m"
	else
		echo -e "\033[40;32m ADD succes\033[0m"
	fi
	fi
	service iptables save &> /dev/null
}
function DeleteBlackIp(){
	/sbin/iptables -D INPUT -s $1 -p tcp -m multiport --destination-ports 25,110,143,80,934,935,443 -j DROP &> /dev/null
	if [ ! $? -eq 0 ];then
		echo -e "\033[40;31m Command ERROR\033[0m"
	else
		echo -e "\033[40;32m Delete succes\033[0m"
	fi
	service iptables save &> /dev/null
	
}

function DeleteWhiteIp(){
	/sbin/iptables -D INPUT -s $1 -j ACCEPT
	if [ ! $? -eq 0 ];then
		echo -e "\033[40;31m Command ERROR\033[0m"
	else
		echo -e "\033[40;32m Delete succes\033[0m"
	fi
	service iptables save &> /dev/null
}

function AboutIpTools(){

	echo -e "\033[40;32m Create By Zyf(jeff)---Iflytek\033[0m"
	echo -e "\033[40;32m Time: 2014/05/26\033[0m"
	echo -e "\033[40;32m QQ:445188383\033[0m"
	echo -e "\033[40;32m if this program have some error please contact me\033[0m"
}

function ShowWhiteIp(){
	IP=`/sbin/iptables -n -L|grep "^ACCEPT"|awk -F" " '{print $4}'`
	echo $IP
}

function ShowMenu(){
echo -e "\033[40;31m--------------Welcome to Use IpTools-----------------\033[0m"
echo -e "\033[40;32m1.Show Black Ip\033[0m"
echo -e "\033[40;32m2.Show White Ip\033[0m"
echo -e "\033[40;32m3.Add white Ip\033[0m"
echo -e "\033[40;32m4.Delete Black Ip\033[0m"
echo -e "\033[40;32m5.Delete White Ip\033[0m"
echo -e "\033[40;32m6.About IpTools\033[0m"
echo -e "\033[40;32mc/C.Clear Screen\033[0m"
echo -e "\033[40;32mq/Q.Quite Program\033[0m"
echo -e "\033[40;31mplease choose(1/2/3/4/5/6/q/Q): \033[0m"
}

ShowMenu
read -p "#:" CHOOSE

while [ $CHOOSE != 'Q' ] &>/dev/null && [ $CHOOSE != 'q' ] &>/dev/null
do
case $CHOOSE in
1)
	ShowBlackIp
	;;
2)
	ShowWhiteIp
	;;
3)
	read -p "please input white Ip:" WIP
	AddwhiteIp $WIP
	;;
4)
	read -p "please input black Ip:" BIP
	DeleteBlackIp $BIP
	;;
5)
	read -p "please input white Ip:" WIP
	DeleteWhiteIp $WIP
	;;
6)
	AboutIpTools
	;;
'c')
	clear
	;;
'C')
	clear
	;;
*)
 	
	echo -e "\033[40;32m ###########ERROR CHOOSE:########\033[0m"
	;;

esac
ShowMenu
read -p "#:" CHOOSE
done

echo -e "\033[40;32m ###########End Program:########\033[0m"
