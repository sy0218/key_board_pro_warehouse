#!/usr/bin/bash

ip_file="/data/work/system_download.txt"

ssh_home="/root/.ssh"

ip_array=($(cat ${ip_file} | grep server_ip | awk -F '|' '{for(i=2; i<=NF; i++) print $i}'))
len_array=${#ip_array[@]}


rs_id=$(cat ${ssh_home}/id_rsa.pub)
echo ${rs_id} >> ${ssh_home}/authorized_keys

dt_ip=${ip_array[0]}
echo $dt_ip
for ((i=1; i<len_array; i++));
do
        sudo /usr/bin/expect << EOD
        spawn scp ${ssh_home}/authorized_keys root@${ip_array[$i]}:${ssh_home}/authorized_keys
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

done
