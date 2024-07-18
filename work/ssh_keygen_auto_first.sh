#!/usr/bin/bash

ip_file="/data/work/system_download.txt"


ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

# ip 돌며 키젠 받기
for ((i=0; i<len_array; i++));
do
        current_ip=${ip_array[$i]}
        
        sudo /usr/bin/expect << EOD
        spawn ssh ${current_ip} "ssh-keygen -t rsa -b 2048 -N '' -f /root/.ssh/id_rsa"
        expect {
        "*yes/no*" {
                send "yes\r"
                exp_continue
        }
        "*assword:" {
                send "nds1101\r"
                exp_continue
        }
        "*Overwrite*" {
                send "y\r"
                exp_continue
        }
        eof
}
EOD
        sleep 2
done
