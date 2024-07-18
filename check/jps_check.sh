#!/usr/bin/bash

ip_file="/data/work/system_download.txt"
ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

# 현재 ip와 다음ip 출력
for ((i=0; i<len_array; i++));
do
        current_ip=${ip_array[$i]}
        echo "------jps on ${current_ip}------------"
        ssh ${current_ip} "jps"
        echo "--------------------------------------"; echo"";
done
