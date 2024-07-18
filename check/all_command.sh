#!/usr/bin/bash

# 인자 개수 확인
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

command=$1
ip_file="/data/work/system_download.txt"
ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

# 현재 ip와 다음ip 출력
for ((i=0; i<len_array; i++));
do
        current_ip=${ip_array[$i]}
        echo "------command ${current_ip}------------"
        ssh ${current_ip} "${command}"
        echo "--------------------------------------"; echo"";
done
