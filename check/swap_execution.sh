#!/usr/bin/bash

ip_file="/data/work/system_download.txt"
ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}


for ((i=0; i<len_array; i++));
do
	current_ip=${ip_array[$i]}
	echo "------Swap on ${current_ip}------------"
	ssh ${current_ip} "swapon /swap.img"
	ssh ${current_ip} "free -h | grep Swap"
	echo "--------------------------------------"; echo"";
done
