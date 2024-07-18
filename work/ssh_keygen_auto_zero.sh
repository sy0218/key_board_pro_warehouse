#!/usr/bin/bash

ip_file="/data/work/system_download.txt"


ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

# 모든 ip 돌며 root 비번 설정
for ((i=0; i<len_array; i++));
do
        current_ip=${ip_array[$i]}
        echo "작업중 서버 ${current_ip}"
sudo /usr/bin/expect << EOD
        spawn ssh ${current_ip} "apt update -y"
        expect {
        "*yes/no*" {
                send "yes\r"
                exp_continue
        }
        "*assword:" {
                send "nds1101\r"
                exp_continue
        }
        eof
}
EOD
        sleep 2


sudo /usr/bin/expect << EOD
        spawn ssh ${current_ip} "apt install ansible -y"
        expect {
        "*yes/no*" {
                send "yes\r"
                exp_continue
        }
        "*assword:" {
                send "nds1101\r"
                exp_continue
        }
        eof
}
EOD
        sleep 2

done
