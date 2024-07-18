#!/usr/bin/bash

# 인자 개수 확인
if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <container_name> <zookeeper_version>"
        exit 1
fi

zoo_server_file="/data/work/system_download.txt"
zoo_array=($(cat ${zoo_server_file} | grep zookeeper_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_zoo_array=${#zoo_array[@]}


container_name=$1
zookeeper_version=$2

for ((i=0; i<len_zoo_array; i++));
do
        current_ip=${zoo_array[$i]}
        echo "------------zookeeper type ${current_ip}------------"
        ssh -t ${current_ip} "docker exec -it ${container_name} /data/sy0218/apache-zookeeper-${zookeeper_version}-bin/bin/zkServer.sh status"
        echo "---------------------------------------------------"; echo"";
done
