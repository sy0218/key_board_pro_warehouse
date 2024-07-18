#!/usr/bin/bash

ip_file="/data/work/system_download.txt"

ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}


# /etc/hosts 빈 파일 만들기
truncate -s 0 /etc/hosts

# ip를 돌며 /etc/hosts 만들기
for ((i=0; i<len_array; i++)); do
        current_ip=${ip_array[$i]}
        echo "작업중 ip ${current_ip}"

etc_host_name=$(expect -c "
spawn ssh ${current_ip} \"hostname\"
expect \"*password*\"
send \"nds1101\r\"
expect eof
" | tail -n 1)

    cleaned_ip_host=$(echo -e ${current_ip} ${etc_host_name} | sed 's/\r//g')
    echo ${cleaned_ip_host} >> /etc/hosts
    sleep 2
done
echo "127.0.0.1 localhost" >> /etc/hosts

# /etc/hosts 파일 각 서버로 scp
for ((si=1; si<len_array; si++)); do
        ssh_ip=${ip_array[$si]}
        echo $ssh_ip

        sudo /usr/bin/expect << EOD
        spawn scp /etc/hosts ${ssh_ip}:/etc/hosts
        expect "*password*"
        send "nds1101\r"
        sleep 2
expect eof
EOD
done
