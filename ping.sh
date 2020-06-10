#!/bin/bash
NOW=$(date +"%Y-%m-%d %T")
declare -A array=([piotr_pc]=10.0.0.10 [piotr_samsung]=10.0.0.11 [piotr_work]=10.0.0.12 [magda_laptop]=10.0.0.13 [michal_pc]=10.0.0.14 [piotr_rpi3_home]=10.0.0.15)

for item in ${!array[@]}
do	
    file=$(grep $item www1/openvpn-status.log | tr '\n' ',')
	IFS=','
	arr=()
    for x in $file; do          
        arr+=($x)
    done   
     	
    connected_since=$(date -D "%a %b %d %H:%M:%S %Y" -d "${arr[4]}" "+%Y-%m-%d %H:%M:%S")
    last_ref=$(date -D "%a %b %d %H:%M:%S %Y" -d "${arr[8]}" "+%Y-%m-%d %H:%M:%S")


	if ping -c1 -w1 ${array[$item]} > /dev/null; then
    	mysql -uxxx -pxxx openwrt -e "UPDATE openvpn SET status='ONLINE', last_online='$NOW' , common_name='${arr[0]}', real_address='${arr[1]}', bytes_received='${arr[2]}', bytes_sent='${arr[3]}', connected_since='$connected_since', last_ref='$last_ref' WHERE virtual_address='${arr[5]}'"
    	else
    	mysql -uxxx -pxxx openwrt -e "UPDATE openvpn SET status='OFFLINE' WHERE virtual_address='${array[$item]}'"
        #echo "UPDATE openvpn SET status='OFFLINE' WHERE virtual_address='${array[$item]}'"
	fi	
done

