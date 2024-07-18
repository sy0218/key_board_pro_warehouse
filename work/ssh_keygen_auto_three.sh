#!/usr/bin/bash

ip_file="/data/work/system_download.txt"

ssh_home="/root/.ssh"

ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}

# 현재 ip와 다음ip 출력
for ((i=1; i<len_array; i++));
do
        current_ip=${ip_array[$i]}
        if (( i < len_array - 1 )); then
                next_ip=${ip_array[$i+1]}
        else
                next_ip='no_field'
        fi

        sudo /usr/bin/expect << EOD
        spawn ssh ${current_ip} "cat ${ssh_home}/id_rsa.pub >> ${ssh_home}/authorized_keys"
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

        sudo /usr/bin/expect << EOD
        spawn scp root@${current_ip}:${ssh_home}/authorized_keys root@${next_ip}:${ssh_home}/authorized_keys
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
